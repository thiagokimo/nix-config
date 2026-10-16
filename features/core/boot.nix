# systemd-boot on UEFI.
{
  flake.modules.nixos.core = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
