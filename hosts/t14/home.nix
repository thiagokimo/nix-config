{pkgs, ...}: {
  imports = [
    ../../modules/home/hyprland
    ../../modules/home/mime.nix
    ../../modules/home/programs/dunst.nix
    ../../modules/home/programs/kitty.nix
    ../../modules/home/programs/waybar
    ../../modules/home/programs/wofi.nix
    ../../modules/home/stylix.nix

    # TODO Fix this
    # ../../modules/home/programs/design.nix
  ];

  home = {
    packages = with pkgs; [
      google-chrome
      vlc
    ];
    sessionVariables = {};
    file = {};
  };
}
