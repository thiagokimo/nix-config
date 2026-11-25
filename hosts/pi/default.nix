# Raspberry Pi 4 in an Argon ONE M.2 case, booting from the case's M.2 SATA SSD:
# a small always-on home server, reached over SSH.
{
  config,
  inputs,
  ...
}: {
  vars.hosts.pi = {
    system = "aarch64-linux";
    features = config.vars.featureSets.base ++ ["failure-alerts" "jellyfin" "monitoring"];
    # red with a Raspberry Pi glyph, apart from the other hosts.
    accent = "base08";
    icon = "󰐿";
    tailscaleIp = "100.115.255.84";
    # git on the Pi pushes and pulls with the key of the laptop connecting. The
    # matching public key has to be at ~/.ssh/id_ed25519.pub on the Pi, since
    # features/cli/gh.nix sets IdentitiesOnly for github.com.
    forwardAgent = true;

    nixos = {pkgs, ...}: {
      imports = [
        ./_hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
      ];

      # The nixos-hardware profile builds the Raspberry Pi vendor kernel, which
      # the binary cache doesn't have, so the Pi would compile it for hours. The
      # mainline kernel from the cache supports the Pi 4 too, and it is what the
      # official NixOS aarch64 image boots.
      boot.kernelPackages = pkgs.linuxPackages;

      # Boots through the Pi firmware, U-Boot and extlinux, not UEFI.
      boot.loader = {
        systemd-boot.enable = false;
        efi.canTouchEfiVariables = false;
      };

      # Fan curve and power button of the Argon ONE case, over I2C and GPIO 4.
      services.hardware.argonone.enable = true;

      # The Wi-Fi starts with no country ("WORLD"), which narrows its channels
      # until an access point announces one. The Pi stays home, so set Brazil
      # from boot. iw shows and changes it at runtime.
      boot.extraModprobeConfig = "options cfg80211 ieee80211_regdom=BR";
      environment.systemPackages = [pkgs.iw];

      boot.kernelParams = [
        # The case's SSD sits behind an ASMedia ASM1156 USB-SATA bridge
        # (174c:1156). Under a long rsync the Pi hung with the journal cut off
        # mid-line, the pattern of ASMedia bridges hanging in UAS mode on the
        # Pi 4. Plain USB mass storage is slower, but still far faster than the
        # Wi-Fi feeding it.
        "usb-storage.quirks=174c:1156:u"
        # Reboot 10 seconds after a kernel panic; see the watchdog below.
        "panic=10"
      ];

      # Compressed swap in RAM, gentler on the SSD than a swapfile.
      zramSwap.enable = true;

      # Reboots instead of staying hung until someone is home to unplug it.
      # - systemd pets the SoC's hardware watchdog (bcm2835_wdt, 15s at most);
      #   if the kernel or systemd freezes and stops petting it, the hardware
      #   resets the board after 10s. The same timer covers a reboot that
      #   stalls on the way down.
      # - A process stuck waiting on the disk for 2 minutes (the kernel's
      #   hung_task_timeout_secs) panics the kernel, as when the USB SSD stops
      #   answering and SSH can't even send its banner; panic=10 (above) then
      #   reboots 10 seconds after any panic, which NixOS otherwise leaves hung.
      # After one of these, `journalctl --list-boots` shows the new boot and
      # `journalctl -b -1` ends abruptly where the old one died.
      systemd.settings.Manager = {
        RuntimeWatchdogSec = "10s";
        RebootWatchdogSec = "10s";
      };
      boot.kernel.sysctl."kernel.hung_task_panic" = 1;
    };
  };
}
