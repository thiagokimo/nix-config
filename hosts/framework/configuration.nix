{
  config,
  ...
}: {
  imports = [
    ../modules/boot.nix
    ../modules/fonts.nix
    ../modules/hyprland.nix
    ../modules/keyboard.nix
    ../modules/network.nix
    ../modules/nix.nix
    ../modules/sound.nix
    ../modules/timezone.nix
    ../modules/tuigreet.nix
    ../modules/users.nix
    ../modules/utils.nix
    ../modules/zsh.nix
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = config.var.stateVersion;
}
