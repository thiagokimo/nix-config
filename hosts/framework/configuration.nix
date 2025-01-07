{config, ...}: {
  imports = [
    ../../modules/nixos/boot.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/home-manager.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/keyboard.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/nixpkgs.nix
    ../../modules/nixos/power.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/timezone.nix
    ../../modules/nixos/tuigreet.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/utils.nix
    ../../modules/nixos/zsh.nix
    ./theme.nix
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = config.var.stateVersion;
}
