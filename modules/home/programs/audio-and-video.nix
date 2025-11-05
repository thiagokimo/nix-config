{pkgs, ...}: {
  home.packages = with pkgs; [
    vlc # video player
    wiremix # audio management
  ];
}
