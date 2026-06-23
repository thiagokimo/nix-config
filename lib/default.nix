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

  buildChecks = {
    pkgs,
    self,
    hosts,
  }: let
    system = pkgs.system;
    systemHosts = inputs.nixpkgs.lib.filterAttrs (hostname: hostSystem: hostSystem == system) hosts;
  in
    {
      # Verify formatting of all Nix files in the flake
      formatting =
        pkgs.runCommand "check-formatting" {
          buildInputs = [pkgs.alejandra];
        } ''
          alejandra --check ${self}
          touch $out
        '';
    }
    // (inputs.nixpkgs.lib.mapAttrs' (hostname: hostSystem: {
        name = "nixos-${hostname}";
        value = self.nixosConfigurations.${hostname}.config.system.build.toplevel;
      })
      systemHosts)
    // (inputs.nixpkgs.lib.mapAttrs' (hostname: hostSystem: {
        name = "home-${hostname}";
        value = self.homeConfigurations."${vars.username}@${hostname}".activationPackage;
      })
      systemHosts);
}
