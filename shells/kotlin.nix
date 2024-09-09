{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    jetbrains.idea-community
  ];
  name = "Kotlin Dev Environment";
  shellHook = ''
    echo "Entering Kotlin development environment"
  '';
}
