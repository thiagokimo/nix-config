{
  inputs,
  vars,
  myLib ? {},
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  buildSystem = {
    system,
    hostname,
    user ? vars.user.name,
    modules ? [],
  }:
    nixosSystem {
      inherit system;
      specialArgs = {inherit inputs user hostname vars myLib;};
      modules =
        [
          {nixpkgs.hostPlatform = system;}
          ../hosts/${hostname}
        ]
        ++ modules;
    };

  buildHome = {
    system,
    hostname ? null,
    user ? vars.user.name,
    modules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs user hostname vars myLib;};
      modules =
        [
          ../modules/home-manager
        ]
        ++ modules;
    };

  buildChecks = {
    pkgs,
    self,
    hosts ? vars.hosts,
  }: let
    system = pkgs.stdenv.hostPlatform.system;
    systemHosts =
      inputs.nixpkgs.lib.filterAttrs (
        hostname: hostCfg:
          (
            if builtins.isAttrs hostCfg
            then hostCfg.system
            else hostCfg
          )
          == system
      )
      hosts;
  in
    {
      formatting =
        pkgs.runCommand "check-formatting" {
          buildInputs = [pkgs.alejandra];
        } ''
          alejandra --check ${self}
          touch $out
        '';
    }
    // (inputs.nixpkgs.lib.mapAttrs' (hostname: hostCfg: {
        name = "nixos-${hostname}";
        value = self.nixosConfigurations.${hostname}.config.system.build.toplevel;
      })
      systemHosts)
    // (inputs.nixpkgs.lib.mapAttrs' (hostname: hostCfg: {
        name = "home-${hostname}";
        value = self.homeConfigurations."${vars.user.name}@${hostname}".activationPackage;
      })
      systemHosts);
}
