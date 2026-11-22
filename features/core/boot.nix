# systemd-boot on UEFI. Defaults, so a board that boots another way, such as the
# Raspberry Pi through extlinux, can turn it off.
{
  flake.modules.nixos.core = {lib, ...}: {
    boot = {
      loader = {
        systemd-boot.enable = lib.mkDefault true;
        efi.canTouchEfiVariables = lib.mkDefault true;
      };
    };
  };
}
