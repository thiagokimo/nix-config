# The fwupd service, which the update script talks to.
{
  flake.modules.nixos.firmware = {
    services.fwupd.enable = true;
  };
}
