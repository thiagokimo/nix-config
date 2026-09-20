{pkgs, ...}: {
  home.packages = with pkgs; [
    google-chrome
    calibre
    koreader
    nautilus
    loupe
    papers
  ];
}
