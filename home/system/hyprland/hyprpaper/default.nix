{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };
  home.file.".config/hypr/hyprpaper.conf" = {
    text = builtins.readFile ./hyprpaper.conf;
  };
}
