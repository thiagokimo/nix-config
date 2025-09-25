{
  config,
  ...
}: {
  imports = [
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/console.nix
    ./modules/environment.nix
    ./modules/fonts.nix
    ./modules/hardware-configuration.nix
    ./modules/home-manager.nix
    ./modules/hyprland.nix
    ./modules/keyboard.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/variables.nix
  ];

  programs.zsh.enable = true;
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = config.var.stateVersion;
}
