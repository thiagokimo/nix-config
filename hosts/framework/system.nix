{pkgs, ...}: {
  time.timeZone = "America/Sao_Paulo";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
