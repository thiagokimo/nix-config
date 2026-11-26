# Lenovo ThinkPad T14s (Intel): the home server, headless and reached over SSH.
{
  config,
  inputs,
  ...
}: {
  vars.hosts.t14s = {
    system = "x86_64-linux";
    features = config.vars.featureSets.base ++ ["failure-alerts" "github-runners" "ssh-agent"];
    # purple with a server glyph, apart from the laptops' aqua and yellow.
    accent = "base0E";
    icon = "󰒋";
    tailscaleIp = "100.115.181.106";

    nixos = {
      imports = [
        ./_hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s
      ];

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

      # Without the desktop there is no power-profiles-daemon, and the
      # nixos-hardware laptop profile would turn on TLP instead. Its power saving
      # (USB autosuspend, for one) doesn't suit a machine that is always on.
      services.tlp.enable = false;
    };
  };
}
