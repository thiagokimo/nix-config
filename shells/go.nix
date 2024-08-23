{
  nixpkgs,
  system,
  inputs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      go
      go-outline
      gopls
      gopkgs
      go-tools
      delve
    ];
    name = "Go environment";
    shellHook = ''
      echo "Entering Go development environment"
    '';
  }
