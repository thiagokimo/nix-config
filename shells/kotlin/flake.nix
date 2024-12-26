{
  description = "Kotlin dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let

    javaVersion = "23";
    supportedSystems = [
      "x86_64-linux"
    ];

    forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import nixpkgs {inherit system; overlays = [ self.overlays.default ];};
    });
  in {
    formatter = forEachSupportedSystem({pkgs}: {pkgs.alejandra});
    overlays.default = final: prev:
      let
        jdk = prev."jdk${toString javaVersion}";
      in {
        gradle = prev.gradle.override { java = jdk; };
        kotlin = prev.kotlin.override { jre = jdk; };
      };

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            gcc
            gradle
            kotlin
            ncurses
            patchelf
            zlib
          ];
        };
        env = {};
        shellHook = ''
        '';
      });

  };
}
