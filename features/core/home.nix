# Home Manager basics: the user, its home and session variables.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.core = {
    programs.home-manager.enable = true;

    home = {
      username = vars.user.name;
      homeDirectory = vars.user.home;
      stateVersion = vars.system.stateVersion;
      pointerCursor.enable = true;

      sessionVariables = vars.sessionVariables;
    };
  };
}
