{
  inputs,
  vars,
  myLib ? {},
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  # The modules of the given class (nixos or homeManager) for the features a
  # host lists. A feature can have a part for either class or both. Names are
  # sorted, so the order of the list doesn't matter.
  featureModules = class: hostname: let
    inherit (inputs.self) modules;
    features = builtins.sort builtins.lessThan vars.hosts.${hostname}.features;
    unknown = builtins.filter (f: !(modules.nixos ? ${f} || modules.homeManager ? ${f})) features;
  in
    if unknown != []
    then throw "Host ${hostname} lists unknown features: ${toString unknown}"
    else map (f: modules.${class}.${f}) (builtins.filter (f: modules.${class} ? ${f}) features);
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
        ++ featureModules "nixos" hostname
        ++ modules;
    };

  buildHome = {
    system,
    hostname,
    user ? vars.user.name,
    modules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs user hostname vars myLib;};
      modules = featureModules "homeManager" hostname ++ modules;
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
