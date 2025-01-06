{
  description = "Thiago's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-wallpapers = {
      url = "github:thiagokimo/nix-wallpapers";
      flake = false;
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nix-wallpapers,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    formatter = forAllSystems (system: pkgsFor.${system}.alejandra);

    # Shell that I use to develop this own package
    devShells.default = forAllSystems (system:
      with pkgsFor.${system};
        mkShell {
          env = {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
          };
          nativeBuildInputs = [
            nix
            home-manager
          ];
          shellHook = ''
            Welcome back, Thiago :)
          '';
        }
    );

    # Entry point for my NixOS machines
    # TODO add entry point for my non NixOS machines (pixelbook, thinkpads, etc)
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-hardware.nixosModules.framework-13-7040-amd
          stylix.nixosModules.stylix
          {
            nixpkgs.overlays = [inputs.hyprpanel.overlay];
          }
          ./hosts/framework/configuration.nix
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };

    # Dev environments I use to begin various projects
    templates = {
      go = {
        path = ./dev-environments/go;
        description = "Go dev environment";
      };
      kotlin = {
        path = ./dev-environments/kotlin;
        description = "Kotlin dev environment";
      };
      flutter = {
        path = ./dev-environments/flutter;
        description = "Flutter dev environment";
      };
      nix = {
        path = ./dev-environments/nix;
        description = "Nix dev environment";
      };
    };
  };
}
