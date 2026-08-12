{pkgs, ...}: {
  home.packages = with pkgs; [
    vlc # video player
    wiremix # audio management
    yt-dlp # yt downloader
    nicotine-plus # soulseek client
    kew # audio player
  ];
}
