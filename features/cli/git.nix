# Git identity.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.cli = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Thiago Rocha";
        email = vars.user.email;
      };
    };
  };
}
