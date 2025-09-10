{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./boot.nix
    ./console.nix
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

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  programs.zsh.enable = true;
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = config.var.stateVersion;
}
