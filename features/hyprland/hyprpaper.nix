# Wallpaper daemon for Hyprland. Stylix sets the wallpaper.
{
  flake.modules.homeManager.hyprland = {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2;
      };
    };
  };
}
