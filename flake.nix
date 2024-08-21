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
    lib = nixpkgs.lib // home-manager.lib;
    username = "thiago";
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    inherit lib;
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
          ./homes/thiago
        ];

        # Required by home-manager standalone version
        # TODO find out a better way to specify the system
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs username;};
      };
    };
  };
}
