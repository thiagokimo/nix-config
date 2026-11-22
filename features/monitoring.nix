# Uptime monitoring: Gatus checks every other host over Tailscale and posts to
# ntfy, which pushes the alerts to the phone. Both run on the host that lists
# this feature, and both are reached over the tailnet only: tailscale0 is a
# trusted interface, and no port is opened on any other.
#
#   Dashboard:     http://<host>:8080, or http://status.lan with the proxy
#   Notifications: subscribe to the `homelab` topic on http://<host>:2586 (or
#                  http://ntfy.lan) in the ntfy app, with Tailscale on.
#
# Servers (hosts without the desktop feature) alert when they go down and when
# they come back. Laptops come and go, so they only show on the dashboard.
{
  config,
  lib,
  ...
}: let
  inherit (config) vars;

  gatusPort = 8080;
  ntfyPort = 2586;
  topic = "homelab";
in {
  flake.modules.nixos.monitoring = {config, ...}: let
    self = config.networking.hostName;
    address = vars.hosts.${self}.tailscaleIp or self;

    others = lib.filterAttrs (name: host: name != self && host.tailscaleIp != null) vars.hosts;
    isServer = host: !(builtins.elem "desktop" host.features);

    hostEndpoints = name: host: let
      alerts = lib.optional (isServer host) {type = "ntfy";};
    in [
      {
        name = "${name} ping";
        group = name;
        url = "icmp://${host.tailscaleIp}";
        interval = "1m";
        conditions = ["[CONNECTED] == true"];
        inherit alerts;
      }
      {
        name = "${name} ssh";
        group = name;
        url = "tcp://${host.tailscaleIp}:22";
        interval = "1m";
        conditions = ["[CONNECTED] == true"];
        inherit alerts;
      }
    ];
  in {
    services.gatus = {
      enable = true;
      settings = {
        web.port = gatusPort;
        ui.title = "Home lab";
        # History survives restarts.
        storage = {
          type = "sqlite";
          path = "/var/lib/gatus/data.db";
        };

        alerting.ntfy = {
          url = "http://127.0.0.1:${toString ntfyPort}";
          inherit topic;
          priority = 4;
          # Three failed checks in a row (about 3 minutes) before an alert, two
          # good ones before the all-clear.
          default-alert = {
            failure-threshold = 3;
            success-threshold = 2;
            send-on-resolved = true;
          };
        };

        endpoints =
          lib.concatLists (lib.mapAttrsToList hostEndpoints others)
          ++ [
            # The monitoring host itself. These can't alert: if they fail,
            # the alert has no way out.
            {
              name = "ntfy";
              group = self;
              url = "http://127.0.0.1:${toString ntfyPort}/v1/health";
              interval = "1m";
              conditions = ["[STATUS] == 200" "[BODY].healthy == true"];
            }
            {
              name = "internet";
              group = self;
              url = "https://github.com";
              interval = "5m";
              conditions = ["[STATUS] == 200"];
            }
          ];
      };
    };

    services.ntfy-sh = {
      enable = true;
      settings = {
        base-url = "http://${address}:${toString ntfyPort}";
        # All interfaces, so the phone reaches it over the tailnet; the
        # firewall keeps it off the home network.
        listen-http = ":${toString ntfyPort}";
        # Requests through the proxy carry the client's address in
        # X-Forwarded-For; without this, they'd all share one rate limit.
        behind-proxy = true;
      };
    };

    # Friendly names, with the proxy feature on the same host.
    services.caddy.virtualHosts = lib.mkIf config.services.caddy.enable {
      "http://status.${vars.lanDomain}".extraConfig = "reverse_proxy 127.0.0.1:${toString gatusPort}";
      "http://ntfy.${vars.lanDomain}".extraConfig = "reverse_proxy 127.0.0.1:${toString ntfyPort}";
    };
  };
}
