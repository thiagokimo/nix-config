{
  description = "Nix dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let

    supportedSystems = [
      "x86_64-linux"
    ];

    forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import nixpkgs {inherit system;};
    });
  in {
    formatter = forEachSupporedSystem({pkgs}: {pkgs.alejandra;});
    devShells = forEachSupportedSystem({pkgs} : {
      default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
          home-manager
          nix
          cachix
          lorri
          niv
          nixfmt-classic
          statix
          vulnix
          haskellPackages.dhall-nix
        ];
        env = {
          NIX_CONFIG = "extra-experimental-features = nix-command flakes";
        };
        shellHook = ''
        '';
      };
    });
  };
}
