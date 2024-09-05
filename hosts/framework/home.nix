{config, pkgs, ...}: {

  imports = [
    ./variables.nix

    ../../home/programs/cli
    ../../home/scripts
    ../../home/system/hyprland
    ../../home/system/wofi
    ../../home/system/mime
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

      # Dev
      jetbrains.idea-community
      vscode
      postman
      go
      nodejs
      jq

      # Fun
      peaclock
      cbonsai
      pipes
      cmatrix
    ];
  };

  programs.home-manager.enable = true;
}
