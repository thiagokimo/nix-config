# The host a Home Manager configuration is built for. modules/flake/hosts.nix
# sets it, and NixOS has networking.hostName for the same purpose.
{
  flake.modules.homeManager.core = {lib, ...}: {
    options.host.name = lib.mkOption {
      type = lib.types.str;
      description = "Name of the host in vars.hosts.";
    };
  };
}
