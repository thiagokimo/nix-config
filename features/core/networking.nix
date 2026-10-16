# NetworkManager. modules/flake/hosts.nix sets the host name.
{
  flake.modules.nixos.core = {
    networking = {
      networkmanager.enable = true;

      firewall.allowedTCPPorts = [
        2234 # soulseek port
      ];
      firewall.allowedUDPPorts = [
        2234 # soulseek port
      ];
    };
  };
}
