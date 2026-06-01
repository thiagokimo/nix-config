{pkgs, ...}: {
  home.packages = with pkgs; [
    google-chrome
    calibre
    koreader
    hakuneko
  ];
}
