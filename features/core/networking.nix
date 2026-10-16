# NetworkManager. modules/flake/hosts.nix sets the host name.
{
  flake.modules.nixos.core = {
    networking.networkmanager.enable = true;
  };
}
