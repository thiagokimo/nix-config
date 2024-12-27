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

    # Entry point for my NixOS machines
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

    # Entry point for my non NixOS machines :P
    # homeConfigurations = {
    #   "thiago" = home-manager.lib.homeManagerConfiguration {
    #     modules = [./homes/thiago];

    #     # Required by home-manager standalone version
    #     # TODO find out a better way to specify the system
    #     pkgs = pkgsFor.x86_64-linux;
    #     extraSpecialArgs = {inherit inputs outputs;};
    #   };
    # };
    templates = {
      go = {
        path = ./templates/go;
        description = "Go dev environment";
      };
      kotlin = {
        path = ./templates/kotlin;
        description = "Kotlin dev environment";
      };
      flutter = {
        path = ./templates/flutter;
        description = "Flutter dev environment";
      };
      nix = {
        path = ./templates/nix;
        description = "Nix dev environment";
      };
    };
  };
}
