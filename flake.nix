{
  description = "My things :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
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
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];

    vars = import ./vars.nix;
    myLib = import ./lib {inherit inputs;};

    hosts = {
      framework = "x86_64-linux";
      t14 = "x86_64-linux";

      # TODO use standalone home manager??
      x13s = "aarch64-linux";

      # TODO fix penguin host
      # penguin = x86_64-linux
    };
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    devShells = forAllSystems (system: import ./shell.nix nixpkgs.legacyPackages.${system});

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
