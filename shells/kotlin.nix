{pkgs ? import <nixpkgs> {}, ...}: {
  kotlin = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      jetbrains.idea-community
    ];
    name = "Kotlin dev shell";
  };
}
