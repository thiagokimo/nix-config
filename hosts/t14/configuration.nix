{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./hyprland.nix
    ./keyboard.nix
    ./locale.nix
    ./networking.nix
    ./services.nix
  ];

  users.users.thiago = {
    isNormalUser = true;
    description = "Thiago";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = "25.05";
}
