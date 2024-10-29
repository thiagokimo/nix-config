{ config, ...}: let
  wallpaper = config.stylix.image;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      wallpaper = "${wallpaper}";
      preload = "${wallpaper}";
    };
  };
}
