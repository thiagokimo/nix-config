{
  nixpkgs,
  system,
  inputs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [];
    name = "";
    shellHook = '''';
  }
