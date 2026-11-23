# NetworkManager, with systemd-resolved behind /etc/resolv.conf. modules/flake/hosts.nix
# sets the host name.
#
# With resolved, Tailscale only takes the tailnet's names (*.ts.net and the bare
# host names, through its search domain) and every other query goes to the DNS
# server of the network the host is on. Without it Tailscale rewrites
# resolv.conf to send everything through 100.100.100.100, which gets in the way
# of captive portals.
{
  flake.modules.nixos.core = {
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    services.resolved.enable = true;
  };
}
