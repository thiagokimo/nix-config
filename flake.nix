{
  description = "Thiago's NixOS configuration";

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
    ...
  } @ inputs: let
    username = "thiago";
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    devShells = forAllSystems (system: import ./shell.nix pkgsFor.${system});
    formatter = forAllSystems (system: pkgsFor.${system}.alejandra);

    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        modules = [./hosts/framework];
        specialArgs = {
          inherit self inputs username;
        };
      };
    };
  };
}
