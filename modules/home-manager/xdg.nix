{inputs, pkgs, vars, ...}: let
  browser = "${vars.browser}";
  editor = "${vars.editor}";
in {
  xdg = {
    portal = {
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
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/markdown" = "${editor}.desktop";
        "text/plain" = "${editor}.desktop";
        "text/html" = "${browser}.desktop";
        "image/png" = "${browser}.desktop";
        "image/jpeg" = "${browser}.desktop";
        "image/gif" = "${browser}.desktop";
        "x-scheme-handler/http" = "${browser}.desktop";
        "x-scheme-handler/https" = "${browser}.desktop";
        "x-scheme-handler/about" = "${browser}.desktop";
        "x-scheme-handler/unknown" = "${browser}.desktop";
        "application/pdf" = "${browser}.desktop";
      };
    };
  };
}
