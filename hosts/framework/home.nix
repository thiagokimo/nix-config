{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/home.nix
    ../../modules/home-manager/programs/thunar.nix
    ../../modules/home-manager/programs/design.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/scripts/nix-kimo.nix
    ../../modules/home-manager/system/hypr
    ../../modules/home-manager/system/mime.nix
    ../../modules/home-manager/system/wofi.nix
    ./variables.nix
  ];

  home = {
    packages = with pkgs; [
      # Apps
      discord
      vlc
      google-chrome
    ];

    # Used in hyprpanel and hyprlock
    file.".profile-picture.jpeg" = {source = ./profile-picture.jpeg;};
  };
}
