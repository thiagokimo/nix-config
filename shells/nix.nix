{
  nixpkgs,
  system,
  inputs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in
  pkgs.mkShell {
    env = {
      NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    };
    # NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      alejandra
      home-manager
      nix
    ];
    name = "Nix environment";
    shellHook = ''
      echo "Entering Nix development environment"
    '';
  }
