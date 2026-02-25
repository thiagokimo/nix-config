{inputs}: let
  vars = import ../vars.nix;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  buildSystem = {
    system,
    hostname,
    user ? vars.username,
    modules ? [],
  }:
    nixosSystem {
      inherit system;
      specialArgs = {inherit inputs user hostname vars;};
      modules =
        [
          {nixpkgs.hostPlatform = system;}
          ../hosts/${hostname}
        ]
        ++ modules;
    };

  buildHome = {
    system,
    user ? vars.username,
    modules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs user vars;};
      modules =
        [
          ../modules/home-manager
        ]
        ++ modules;
    };
}
