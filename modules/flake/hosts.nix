# Builds a NixOS and a Home Manager configuration for each host in vars.hosts,
# from the host's own NixOS module and the features it lists, and checks that
# they build.
{
  config,
  inputs,
  lib,
  self,
  ...
}: let
  inherit (config) vars;
  inherit (config.flake) modules;

  # The modules of the given class (nixos or homeManager) for the features a
  # host lists. A feature can have a part for either class or both. Names are
  # sorted, so the order of the list doesn't matter.
  featureModules = class: name: host: let
    features = builtins.sort builtins.lessThan host.features;
    unknown = builtins.filter (f: !(modules.nixos ? ${f} || modules.homeManager ? ${f})) features;
  in
    if unknown != []
    then throw "Host ${name} lists unknown features: ${toString unknown}"
    else map (f: modules.${class}.${f}) (builtins.filter (f: modules.${class} ? ${f}) features);

  homeName = name: "${vars.user.name}@${name}";
in {
  flake.nixosConfigurations = lib.mapAttrs (name: host:
    inputs.nixpkgs.lib.nixosSystem {
      modules =
        [
          {
            nixpkgs.hostPlatform = host.system;
            networking.hostName = name;
          }
          host.nixos
        ]
        ++ featureModules "nixos" name host;
    })
  vars.hosts;

  flake.homeConfigurations = lib.mapAttrs' (name: host:
    lib.nameValuePair (homeName name) (inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${host.system};
      modules = [{host.name = name;}] ++ featureModules "homeManager" name host;
    }))
  vars.hosts;

  perSystem = {
    pkgs,
    system,
    ...
  }: let
    hosts = lib.filterAttrs (_: host: host.system == system) vars.hosts;
  in {
    checks =
      {
        formatting =
          pkgs.runCommand "check-formatting" {
            buildInputs = [pkgs.alejandra];
          } ''
            alejandra --check ${self}
            touch $out
          '';
      }
      // lib.mapAttrs' (name: _: lib.nameValuePair "nixos-${name}" self.nixosConfigurations.${name}.config.system.build.toplevel) hosts
      // lib.mapAttrs' (name: _: lib.nameValuePair "home-${name}" self.homeConfigurations.${homeName name}.activationPackage) hosts;
  };
}
