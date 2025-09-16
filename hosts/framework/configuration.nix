{config, ...}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./home-manager.nix
    ./hyprland.nix
    ./keyboard.nix
    ./network.nix
    ./nix.nix
    ./nixpkgs.nix
    ./power.nix
    ./sound.nix
    ./steam.nix
    ./theme.nix
    ./timezone.nix
    ./tuigreet.nix
    ./users.nix
    ./utils.nix
    ./variables.nix
    ./zsh.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = config.var.stateVersion;
}
