{
  description = "This flake contains the setup for my machines and home environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    overlays = forAllSystems (system: import ./overlays {inherit inputs;});
    packages = forAllSystems (system: import ./pkgs pkgsFor.${system});
    devShells = forAllSystems (system: import ./shell.nix pkgsFor.${system});
    formatter = forAllSystems (system: pkgsFor.${system}.alejandra);

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
      "thiago" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./homes/thiago
          ./nix/nixpkgs.nix
        ];

        # Find a better way to select the system
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
