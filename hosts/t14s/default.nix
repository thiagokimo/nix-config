# Lenovo ThinkPad T14s (Intel): the home server, headless and reached over SSH.
{
  config,
  inputs,
  ...
}: {
  vars.hosts.t14s = {
    system = "x86_64-linux";
    features = config.vars.featureSets.base ++ ["ai" "docker" "failure-alerts" "github-runners" "jellyfin" "ssh-agent" "watchdog"];
    # purple with a server glyph, apart from the laptops' aqua and yellow.
    accent = "base0E";
    icon = "󰒋";
    tailscaleIp = "100.115.181.106";

    nixos = {pkgs, ...}: {
      imports = [
        ./_hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s
      ];

      # Jellyfin transcodes on the Tiger Lake GPU with Intel Quick Sync, for
      # clients that can't play a file as it is. The media driver (iHD) and
      # oneVPL runtime are what Quick Sync goes through; the compute runtime
      # (OpenCL) does HDR-to-SDR tone mapping.
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [intel-media-driver vpl-gpu-rt intel-compute-runtime];
      };
      services.jellyfin = {
        hardwareAcceleration = {
          enable = true;
          type = "qsv";
          device = "/dev/dri/renderD128";
        };
        # What Tiger Lake's media engine decodes and encodes (AV1 encoding
        # came with Arc). Set here rather than in the web dashboard: the file
        # is written again at every start, so settings copied over from
        # another server, or changed in the dashboard, don't stay.
        transcoding = {
          hardwareDecodingCodecs = {
            h264 = true;
            hevc = true;
            hevc10bit = true;
            hevcRExt10bit = true;
            hevcRExt12bit = true;
            mpeg2 = true;
            vc1 = true;
            vp8 = true;
            vp9 = true;
            av1 = true;
          };
          enableHardwareEncoding = true;
          hardwareEncodingCodecs.hevc = true;
          enableToneMapping = true;
        };
        forceEncodingConfig = true;
      };
      # The render node belongs to the render group.
      users.users.jellyfin.extraGroups = ["render" "video"];

      swapDevices = [
        {
          device = "/swapfile";
          size = 8 * 1024;
        }
      ];

      # The disk unlocks itself at boot with a key sealed in the TPM, so a
      # reboot nobody is home for doesn't stop at the passphrase prompt. The
      # TPM releases the key only on this machine with its Secure Boot state
      # (PCR 7) unchanged; when it refuses, the passphrase still works. The key
      # is enrolled once by hand:
      #   sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 \
      #     /dev/disk/by-uuid/db1ca9f2-342e-40f4-ab5e-7dd5ca81ea37
      # and again, with --wipe-slot=tpm2 added, after a Secure Boot change
      # such as a dbx update from firmware-update. The BIOS keeps anyone from
      # booting other media to get at the unlocked disk: a supervisor
      # password, and booting from USB turned off.
      boot.initrd.luks.devices."luks-db1ca9f2-342e-40f4-ab5e-7dd5ca81ea37".crypttabExtraOpts = ["tpm2-device=auto"];
      # With the disk unlocked at boot, editing the kernel command line in the
      # boot menu (init=/bin/sh) would give anyone at the keyboard a root shell.
      boot.loader.systemd-boot.editor = false;

      # Start the user's systemd instance at boot and keep it after logout, so
      # user services such as the SSH agent don't depend on an open SSH session.
      users.users.${config.vars.user.name}.linger = true;

      services.logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
      systemd.targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
      };

      # Plugged in day and night, so the battery stops charging at 80% and
      # only starts again below 75%; sitting at 100% wears it faster. The
      # thresholds live in the battery's firmware (thinkpad_acpi), and are set
      # again at every boot. The start threshold has to stay below the end one,
      # so it's written again once the end is in place.
      systemd.services.battery-charge-thresholds = {
        description = "Cap the battery's charge at 80%";
        wantedBy = ["multi-user.target"];
        serviceConfig.Type = "oneshot";
        script = ''
          battery=/sys/class/power_supply/BAT0
          echo 75 > "$battery/charge_control_start_threshold" || true
          echo 80 > "$battery/charge_control_end_threshold"
          echo 75 > "$battery/charge_control_start_threshold"
        '';
      };

      # Without the desktop there is no power-profiles-daemon, and the
      # nixos-hardware laptop profile would turn on TLP instead. Its power saving
      # (USB autosuspend, for one) doesn't suit a machine that is always on.
      services.tlp.enable = false;
    };
  };
}
