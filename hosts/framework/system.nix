{pkgs, ...}: {
  time.timeZone = "America/Sao_Paulo";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    hyprland
    git
    vim
    curl
    wget
  ];
  system.stateVersion = "24.05";
}
