{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./keyboard.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./user.nix
    ./wm/hyprland.nix
  ];

  system.stateVersion = "24.05";

  # Clock
  time.timeZone = "America/Sao_Paulo";
}
