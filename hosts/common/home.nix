{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/programs/cli
    ../../modules/home-manager/programs/dev
    ../../modules/home-manager/scripts/nix-kimo.nix
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

    # Used in hyprpanel and hyprlock
    file.".profile-picture.jpeg" = {source = ./profile-picture.jpeg;};
  };

  programs.home-manager.enable = true;
}
