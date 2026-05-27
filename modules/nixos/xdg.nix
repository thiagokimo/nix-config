{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config = {
      common = { default = [ "gtk" ]; };
      hyprland = { default = [ "hyprland" "gtk" ]; };
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
