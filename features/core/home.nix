# Home Manager basics: the user, its home and session variables.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.core = {config, ...}: {
    programs.home-manager.enable = true;

    home = {
      username = vars.user.name;
      homeDirectory = vars.user.home;
      stateVersion = vars.system.stateVersion;
      pointerCursor.enable = true;

      # XDG_DATA_HOME comes from xdg.dataHome. Turning on xdg.enable would
      # export it too, but it also moves the zsh dotfiles into ~/.config/zsh.
      sessionVariables =
        vars.sessionVariables
        // {
          XDG_DATA_HOME = config.xdg.dataHome;
        };
    };
  };
}
