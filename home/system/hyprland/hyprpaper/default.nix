{ config, ...}: let 
  wallpaper = "${config.var.theme.wallpaper}";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = wallpaper;
      wallpaper = [", ${wallpaper}"];
    };
  };
}
