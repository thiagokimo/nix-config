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
      jetbrains.idea-community
    ];
    name = "Kotlin environment";
    shellHook = ''
      echo "Entering Kotlin development environment"
    '';
  }
