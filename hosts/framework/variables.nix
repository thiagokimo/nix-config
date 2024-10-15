{config, ...}: {
  imports = [../modules/variables-config.nix];

  config.var = {
    stateVersion = "24.05";

    hostname = "framework";
    username = "thiago";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/.config/nix-config";

    keyboardLayout = "us";
    keyboardVariant = "intl";
    location = "Belo Horizonte";
    timeZone = "America/Sao_Paulo";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "pt_BR.UTF-8";

    # TODO Add more theme stuff 
    theme = {
      wallpapersHome = "/home/" + config.var.username + "/wallpapers";
      wallpaper = config.var.theme.wallpapersHome + "/wp11058333.png";

      rounding = 15;
      gaps-in = 10;
      gaps-out = 10 * 2;
      active-opacity = 1;
      inactive-opacity = 0.89;
      blur = true;
      border-size = 3;
      layout = "dwindle";
    };
  };
}
