{
  description = "Home Sweet Home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @inputs: let 
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    
    overlays = import ./overlays {inherit inputs outputs;};
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra); 
    
    nixosConfigurations = {
      # Framework laptop
      framework = lib.nixosSystem {
        modules = [./hosts/framework];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      # Pixelbook
      pixelbook = lib.nixosSystem {
        modules = [./hosts/pixelbook];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      "thiago@pixelbook" = lib.homeManagerConfiguration {
        modules = [./home/pixelbook ./home/nixpkgs.nix];

        # Find a better way to adjust the system
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
