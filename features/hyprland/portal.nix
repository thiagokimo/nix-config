# Desktop portals (file pickers, screen sharing) for the Hyprland session.
{
  flake.modules.homeManager.hyprland = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      config = {
        common = {default = ["hyprland" "gtk"];};
        hyprland = {default = ["hyprland" "gtk"];};
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
