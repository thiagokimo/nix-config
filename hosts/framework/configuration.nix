{config, ...}: {
  imports = [
    ../../nixos/boot.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/hyprland.nix
    ../../nixos/keyboard.nix
    ../../nixos/network.nix
    ../../nixos/nix.nix
    ../../nixos/nixpkgs.nix
    ../../nixos/sound.nix
    ../../nixos/timezone.nix
    ../../nixos/tuigreet.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/power.nix
    ../../nixos/zsh.nix
    ../../themes/stylix/gruvbox-dark.nix
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = config.var.stateVersion;
}
