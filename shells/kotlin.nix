{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    jetbrains.idea-community
  ];
  name = "Kotlin Development Environment";
  shellHook = ''
    echo "Entering Kotlin development environment"
  '';
}
