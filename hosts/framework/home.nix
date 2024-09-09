{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./variables.nix
    ../modules/nixpkgs.nix

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
