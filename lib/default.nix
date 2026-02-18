{ inputs }: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  buildSystem = { system, hostname, user, modules ? [] }: nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user hostname; };
    modules = [
      { nixpkgs.hostPlatform = system; }
      ../hosts/${hostname}
      ../modules/nixos
    ] ++ modules;
  };

  buildHome = { system, user, modules ? [] }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    extraSpecialArgs = { inherit inputs user; };
    modules = [
      ../modules/home-manager
    ] ++ modules;
  };
}
