{
  description = "My things :)";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (inputs.nixpkgs.lib) nixosSystem;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];

    variables = let
      username = "thiago";
    in {
      stateVersion = "25.11";
      username = username;
      email = "kimo@kimo.io";
      path = "/home/${username}/.config/nix-config";
      editor = "nvim";
      browser = "google-chrome-stable";
    };
    buildSystem = host: sys: let
      configVars = variables // {hostName = host;};
    in {
      specialArgs = {inherit inputs outputs configVars;};
      modules = [
        ./hosts/${host}
        { nixpkgs.hostPlatform = sys; }
      ];
    };
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    devShells = forAllSystems (system: import ./shell.nix nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      framework = nixosSystem (buildSystem "framework" "x86_64-linux");
      t14 = nixosSystem (buildSystem "t14" "x86_64-linux");
      x13s = nixosSystem (buildSystem "x13s" "aarch64-linux");
      # TODO fix case for penguin
    };
  };

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
  };
}
