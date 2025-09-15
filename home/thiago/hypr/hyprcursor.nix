{pkgs, ...}: let
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 24;
in {
  home.pointerCursor = {
    name = cursorTheme;
    package = pkgs.bibata-cursors;
    size = cursorSize;
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
