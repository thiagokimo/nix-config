{
  description = "My things :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-wallpapers = {
      url = "github:thiagokimo/nix-wallpapers";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system: let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
          f pkgs
      );
    vars = import ./vars.nix;
    myLib = import ./lib {inherit inputs;};

    hosts = {
      framework = "x86_64-linux";
      t14 = "x86_64-linux";

      # TODO use standalone home manager??
      # x13s = "aarch64-linux";

      # TODO fix penguin host
      # penguin = x86_64-linux
    };
  in {
    packages = forAllSystems (pkgs: import ./pkgs pkgs);
    overlays = import ./overlays {inherit inputs;};
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        name = "nix-config-dev-env";
        buildInputs = with pkgs; [
          antigravity
          nixd
        ];
      };
    });

    nixosConfigurations = builtins.mapAttrs (hostname: system:
      myLib.buildSystem {
        inherit hostname system;
      })
    hosts;

    homeConfigurations =
      nixpkgs.lib.mapAttrs' (hostname: system: {
        name = "${vars.username}@${hostname}";
        value = myLib.buildHome {inherit system;};
      })
      hosts;
  };
}
