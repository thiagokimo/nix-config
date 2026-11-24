# Jellyfin: streams the movies and shows in /srv/media to the Jellyfin apps,
# over the tailnet only (tailscale0 is trusted; no port is opened elsewhere).
#
#   Web and apps: http://<host>:8096, or http://media.lan with the proxy.
#
# The first visit runs the setup wizard, which creates the admin account and
# the libraries: point them at folders under /srv/media. The server's settings
# and watch history live in /var/lib/jellyfin, outside this file.
#
# Media is copied in as the main user, e.g.
#   rsync -av --progress Movies/ pi:/srv/media/movies/
#
# On a Raspberry Pi there's no hardware transcoding, so clients should play
# files directly (quality set to "Max"/"Original"); the CPU manages about one
# 1080p H.264 transcode, and picture-based subtitles (PGS) force one.
#
# With monitoring on the same host, Gatus checks that it answers and alerts
# when it doesn't.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.jellyfin = {
    config,
    lib,
    ...
  }: let
    port = 8096;
    mediaDir = "/srv/media";
  in {
    services.jellyfin.enable = true;

    # Owned by the main user so media can be copied in over SSH; readable by
    # everyone, Jellyfin included.
    systemd.tmpfiles.rules = ["d ${mediaDir} 0755 ${vars.user.name} users -"];

    # Friendly name, with the proxy feature on the same host.
    services.caddy.virtualHosts = lib.mkIf config.services.caddy.enable {
      "http://media.${vars.lanDomain}".extraConfig = "reverse_proxy 127.0.0.1:${toString port}";
    };

    services.gatus.settings.endpoints = lib.mkIf config.services.gatus.enable [
      {
        name = "jellyfin";
        group = config.networking.hostName;
        url = "http://127.0.0.1:${toString port}/health";
        interval = "1m";
        conditions = ["[STATUS] == 200" "[BODY] == Healthy"];
        alerts = [{type = "ntfy";}];
      }
    ];
  };
}
