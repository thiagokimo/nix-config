# Graphical apps.
{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Browsing, reading and files
      google-chrome
      calibre
      koreader
      nautilus
      loupe
      papers

      # Chat
      vesktop

      # Design
      # aseprite
      gimp
      # inkscape
      # krita

      # Audio and video
      vlc # video player
      yt-dlp # yt downloader
      nicotine-plus # soulseek client
      kew # audio player
      cliamp # audio player
      puddletag # edit audio metadata

      # Torrent
      qbittorrent
    ];
  };
}
