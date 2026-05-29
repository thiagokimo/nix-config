{inputs, pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config = {
      common = { default = [ "hyprland" "gtk" ]; };
      hyprland = { default = [ "hyprland" "gtk" ]; };
    };
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
  };
}
