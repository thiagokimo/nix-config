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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    username = "thiago";
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    devShells = forAllSystems (system: import ./shell.nix pkgsFor.${system});
    formatter = forAllSystems (system: pkgsFor.${system}.alejandra);

    # Entry point for my NixOS machines
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        modules = [./hosts/framework];
        specialArgs = {
          inherit self inputs username;
        };
      };
    };

    # Entry point for my non NixOS machines :P
    homeConfigurations = {
      "thiago" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./modules/home-manager
        ];

        # Required by home-manager standalone version
        pkgs = forAllSystems (system:
          import pkgsFor.${system} {
            config.allowUnfree = true;
          });
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
