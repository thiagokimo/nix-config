# Paused: no host lists this feature. Sending every tailnet device's DNS to the
# Pi left them all without DNS while the Pi was off; resume with a fallback.
#
# AdGuard Home: DNS that blocks ads and trackers. Tailnet devices use it once
# the host's Tailscale address is set as the tailnet's global nameserver (with
# "Override local DNS") in the Tailscale admin console; devices at home, once
# the router hands it out as the DNS server.
#
#   Admin page: http://<host>:3000, or http://dns.lan with the proxy; tailnet
#   only.
#
# This file is the whole configuration: changes made in the admin page last
# until the next restart. Query logs and statistics are kept.
#
# With monitoring on the same host, Gatus checks that it answers and blocks,
# and alerts when it doesn't: every device using it loses DNS with it.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.adguard = {
    config,
    lib,
    ...
  }: let
    webPort = 3000;

    # Blocklists from AdGuard's registry, by their registry number.
    filters = {
      "AdGuard DNS filter" = 1;
      "AdAway Default Blocklist" = 2;
    };
  in {
    services.adguardhome = {
      enable = true;
      mutableSettings = false;
      settings = {
        http.address = "0.0.0.0:${toString webPort}";

        dns = {
          bind_hosts = ["0.0.0.0"];
          port = 53;
          # Encrypted upstreams; the bootstrap servers only resolve their names.
          upstream_dns = [
            "https://dns.quad9.net/dns-query"
            "https://cloudflare-dns.com/dns-query"
          ];
          bootstrap_dns = ["9.9.9.9" "1.1.1.1"];
          # Asks both upstreams at once and takes the first answer, rather than
          # waiting on whichever is slower on the current connection.
          upstream_mode = "parallel";
        };

        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
        };

        filters =
          lib.mapAttrsToList (name: id: {
            inherit name id;
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_${toString id}.txt";
          })
          filters;
      };
    };

    # DNS on every interface, so the router can hand it out at home. The admin
    # page stays on the tailnet, where tailscale0 is trusted.
    networking.firewall = {
      allowedTCPPorts = [53];
      allowedUDPPorts = [53];
    };

    # Friendly name, with the proxy feature on the same host.
    services.caddy.virtualHosts = lib.mkIf config.services.caddy.enable {
      "http://dns.${vars.lanDomain}".extraConfig = "reverse_proxy 127.0.0.1:${toString webPort}";
    };

    services.gatus.settings.endpoints = lib.mkIf config.services.gatus.enable [
      {
        name = "dns";
        group = config.networking.hostName;
        url = "127.0.0.1";
        dns = {
          query-name = "github.com";
          query-type = "A";
        };
        interval = "1m";
        conditions = ["[DNS_RCODE] == NOERROR"];
        alerts = [{type = "ntfy";}];
      }
      {
        # A domain on both blocklists, answered with 0.0.0.0 when blocking works.
        name = "dns blocking";
        group = config.networking.hostName;
        url = "127.0.0.1";
        dns = {
          query-name = "doubleclick.net";
          query-type = "A";
        };
        interval = "5m";
        conditions = ["[BODY] == 0.0.0.0"];
        alerts = [{type = "ntfy";}];
      }
    ];
  };
}
