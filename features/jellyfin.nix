# Jellyfin: streams the main user's Media folder (vars.user.mediaDir, with
# Music, Pictures and Videos, the XDG user folders of the desktop) to the
# Jellyfin apps, over the tailnet only (tailscale0 is trusted; no port is
# opened elsewhere).
#
#   Web and apps: http://<host>:8096, or http://media.lan with the proxy.
#
# Jellyfin sees the folder read-only at /media: it can't change or delete the
# files, and the home folder stays closed (mode 700). The first visit runs the
# setup wizard, which creates the admin account and the libraries:
#   Music          -> /media/Music
#   Home videos and photos -> /media/Pictures
#   Movies or Shows        -> /media/Videos
# The server's settings and watch history live in /var/lib/jellyfin, outside
# this file.
#
# Media is copied in as the main user, e.g.
#   rsync -av --progress ~/Media/ pi:Media/
# Files have to be readable by others (the usual 644), as Jellyfin isn't the
# owner.
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
  in {
    services.jellyfin.enable = true;

    # Hosts without the desktop feature don't get the XDG folders, so create
    # them here, owned by the main user and readable by Jellyfin.
    systemd.tmpfiles.rules =
      map (dir: "d ${dir} 0755 ${vars.user.name} users -")
      [
        vars.user.mediaDir
        "${vars.user.mediaDir}/Music"
        "${vars.user.mediaDir}/Pictures"
        "${vars.user.mediaDir}/Videos"
      ];

    # Mounted by systemd before Jellyfin starts, so the home folder's mode
    # doesn't matter.
    systemd.services.jellyfin.serviceConfig.BindReadOnlyPaths = ["${vars.user.mediaDir}:/media"];

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
