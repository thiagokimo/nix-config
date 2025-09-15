{configVars, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = configVars.wallpaper;
      wallpaper = ", ${configVars.wallpaper}";
    };
  };
}
