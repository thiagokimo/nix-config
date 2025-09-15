{pkgs,...}: {
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,24"
    ];
  };
}
