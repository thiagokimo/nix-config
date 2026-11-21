# Raspberry Pi 4 in an Argon ONE M.2 case, booting from the case's M.2 SATA SSD:
# a small always-on home server, reached over SSH.
{
  config,
  inputs,
  ...
}: {
  vars.hosts.pi = {
    system = "aarch64-linux";
    features = config.vars.featureSets.base;
    # red with a Raspberry Pi glyph, apart from the other hosts.
    accent = "base08";
    icon = "󰐿";

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

      # Compressed swap in RAM, gentler on the SSD than a swapfile.
      zramSwap.enable = true;
    };
  };
}
