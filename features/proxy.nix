# Friendly names for the self-hosted services: Caddy on port 80 sends each name
# to its service, so http://status.lan replaces http://pi:8080. Each service
# feature adds its own names as Caddy virtual hosts; with adguard on the same
# host, every name also gets a DNS rewrite to this host's Tailscale address,
# for every device that uses it for DNS.
#
# Plain HTTP: traffic on the tailnet is already encrypted, and port 80 is only
# reachable there (tailscale0 is trusted, no other interface is opened).
{
  config,
  lib,
  ...
}: let
  inherit (config) vars;
in {
  flake.modules.nixos.proxy = {config, ...}: let
    names = map (lib.removePrefix "http://") (lib.attrNames config.services.caddy.virtualHosts);
    address = vars.hosts.${config.networking.hostName}.tailscaleIp;
  in {
    services.caddy.enable = true;

    services.adguardhome.settings = lib.mkIf config.services.adguardhome.enable {
      filtering = {
        rewrites_enabled = true;
        rewrites =
          map (domain: {
            inherit domain;
            answer = address;
            enabled = true;
          })
          names;
      };
    };
  };
}
