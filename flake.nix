{
  description = "My things :)";

  inputs = {
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
    myLib = import ./lib {inherit inputs vars;};
  in {
    packages = forAllSystems (pkgs: import ./pkgs pkgs);
    overlays = import ./overlays {inherit inputs;};
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        name = "nix-config-dev-env";
        buildInputs = with pkgs; [
          alejandra
          antigravity-ide
          nixd
        ];
      };
    });

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

    checks = forAllSystems (pkgs: myLib.buildChecks {inherit pkgs self;});
  };
}
