# Firmware updates through fwupd.
{
  flake.modules.nixos.firmware = {
    services.fwupd.enable = true;
  };
}
