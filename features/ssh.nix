# OpenSSH server.
{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
    };
  };
}
