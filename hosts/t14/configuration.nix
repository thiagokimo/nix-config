{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./home-manager.nix
    ./hyprland.nix
    ./keyboard.nix
    ./locale.nix
    ./networking.nix
    ./services.nix
    ./users.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    neovim 
  ];

  programs.zsh.enable = true;
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = "25.05";
  home-manager.users.thiago = import ../../home/thiago/home.nix;
}
