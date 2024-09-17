{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/programs/cli
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
      firefox
      google-chrome

      # Dev
      jetbrains.idea-community
      vscode
      postman
      go
      nodejs
      jq
      flutter
      jdk11

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
