{
  description = "Home Sweet Home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    overlays = forAllSystems (system: import ./overlays {inherit inputs;});
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    devShells = forAllSystems (system: import ./shell.nix nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      # Framework laptop
      framework = nixpkgs.lib.nixosSystem {
        modules = [./hosts/framework];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      # Pixelbook
      pixelbook = nixpkgs.lib.nixosSystem {
        modules = [./hosts/pixelbook];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      "thiago@pixelbook" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./homes/pixelbook
          ./nix/nixpkgs.nix
        ];

        # Find a better way to adjust the system
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
