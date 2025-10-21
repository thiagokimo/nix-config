{
  description = "My things :)";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux" 
      "aarch64-linux"
    ];
    configVars = {
      username = "thiago";
      email = "kimo@kimo.io";
      path = "/home/${username}/.config/nix-config";
    };
    mkNixOSConfig = host: sys: {
      system = sys; 
      specialArgs = {inherit inputs outputs configVars;};
      modules = [./hosts/${host}];
    };
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    devShells = forAllSystems (system: import ./shell.nix nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      # framework = nixpkgs.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [./hosts/framework];
      # };

      t14 = nixpkgs.lib.nixosSystem(mkNixOSConfig "t14-2" "x86_64-linux");

      # t14 = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = {inherit inputs outputs nixpkgsConfigs;};
      #   modules = [
      #     ./hosts/t14
      #   ];
      # };

      # x13s = nixpkgs.lib.nixosSystem {
      #   system = "aarch64-linux";
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [./hosts/x13s];
      # };
    };

    # homeConfigurations = forAllSystems (system:
    #   home-manager.lib.homeManagerConfiguration {
    #     pkgs = pkgsFor.${system};
    #     extraSpecialArgs = {inherit inputs outputs;};
    #     modules = [./home/thiago];
    #   });
  };
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # hyprland.url = "github:hyprwm/Hyprland";
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
  };

}
