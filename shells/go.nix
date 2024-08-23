{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    go
    go-outline
    gopls
    gopkgs
    go-tools
    delve
  ];
  name = "Go Development Environment";
  shellHook = ''
    echo "Entering Go development environment"
  '';
}
