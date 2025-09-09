{
  description = "My things :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    packages = forAllSystems (system: import ./pkgs pkgsFor.${system});
    overlays = import ./overlays {inherit inputs;};
    formatter = forAllSystems (system: pkgsFor.${system}.alejandra);
    devShells = forAllSystems (system: import ./shell.nix pkgsFor.${system});

    nixosConfigurations = {
      # framework = nixpkgs.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [./hosts/framework];
      # };

      t14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14
          ./hosts/t14
        ];
      };

      # x13s = nixpkgs.lib.nixosSystem {
      #   system = "aarch64-linux";
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [./hosts/x13s];
      # };
    };

    homeConfigurations = forAllSystems (system:
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.${system};
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/thiago];
      });
  };
}
