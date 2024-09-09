{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  env = {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
  };
  nativeBuildInputs = with pkgs; [
    alejandra
    home-manager
    nix
  ];
  name = "Nix Dev Environment";
  shellHook = ''
    echo "Entering Nix development environment"
  '';
}
