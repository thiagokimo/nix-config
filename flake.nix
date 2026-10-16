{
  description = "My things :)";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    # Bare nixpkgs urls
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Nixpkgs cooldowns by Determinate Systems
    # Cooled weekly unstable
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";
    # Cooled stable channel
    nixpkgs-stable.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-26.05-chilled/0.1";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
    flake-parts,
    ...
  } @ inputs: let
    vars = import ./vars.nix;
    myLib = import ./lib {inherit inputs vars;};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      # Every file in features/ is a flake-parts module that adds NixOS and
      # Home Manager modules under flake.modules.
      imports = [
        flake-parts.flakeModules.modules
        (inputs.import-tree ./features)
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        packages = import ./pkgs pkgs;
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {
          name = "nix-config-dev-env";
          buildInputs = with pkgs; [
            alejandra
            antigravity-ide
            nixd
          ];
        };
        checks = myLib.buildChecks {inherit pkgs self;};
      };

      flake = {
        overlays = import ./overlays {inherit inputs;};

        nixosConfigurations = builtins.mapAttrs (hostname: hostCfg:
          myLib.buildSystem {
            inherit hostname;
            system = hostCfg.system;
          })
        vars.hosts;

        homeConfigurations =
          nixpkgs.lib.mapAttrs' (hostname: hostCfg: {
            name = "${vars.user.name}@${hostname}";
            value = myLib.buildHome {
              inherit hostname;
              system = hostCfg.system;
            };
          })
          vars.hosts;
      };
    };
}
