{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./boot.nix
    ./console.nix
    ./environment.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./home-manager.nix
    ./hyprland.nix
    ./keyboard.nix
    ./locale.nix
    ./networking.nix
    ./services.nix
    ./users.nix
    ./variables.nix
  ];

  programs.zsh.enable = true;
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = config.var.stateVersion;
}
