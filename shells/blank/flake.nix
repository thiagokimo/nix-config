{
  description = "A template of a flake that I base my dev environments on";

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

        ];

        env = {};

        shellHook = ''
        '';
      };
    });
  };
}
