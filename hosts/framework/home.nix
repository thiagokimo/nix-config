{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/programs/cli
    ../../home/programs/dev
    ../../home/scripts
    ../../home/system/hyprland
    ../../home/system/mime
    ../../home/system/wofi
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
  };

  programs.home-manager.enable = true;
}
