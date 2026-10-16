# nh, the Nix helper behind the nrs and hms aliases.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.core = {config, ...}: {
    programs.nh = {
      enable = true;

      clean = {
        enable = !config.nix.gc.automatic;
        dates = "weekly";
      };

      flake = vars.user.configDir;
    };
  };
}
