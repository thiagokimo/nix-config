{pkgs, ...}: {
  home.packages = with pkgs; [
    vlc # video player
    yt-dlp # yt downloader
    nicotine-plus # soulseek client
    kew # audio player
    cliamp # audio player
    puddletag # edit audio metadata
  ];
}
