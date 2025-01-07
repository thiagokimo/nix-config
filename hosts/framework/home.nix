{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/programs/cli
    ../../modules/home-manager/programs/dev
    ../../modules/home-manager/programs/thunar.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/system/hyprland
    ../../modules/home-manager/system/hyprpanel
    ../../modules/home-manager/system/hyprpaper
    ../../modules/home-manager/system/mime
    ../../modules/home-manager/system/wofi
    ./variables.nix
  ];

  home = {
    inherit (config.var) username;
    inherit (config.var) homeDirectory;
    inherit (config.var) stateVersion;

    packages = with pkgs; [
      # Apps
      discord
      vlc
      google-chrome

      # Design
      aseprite
      gimp
      inkscape
      krita

      # Fun
      peaclock
      cbonsai
      pipes
      cmatrix
    ];

    # Used in hyprpanel
    file.".profile-picture.jpeg" = {source = ./profile-picture.jpeg;};
  };

  programs.home-manager.enable = true;
}
