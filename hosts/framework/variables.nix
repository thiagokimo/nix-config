{config, ...}: {
  imports = [./variables.nix];

  config.var = {
    hostname = "framework";
    username = "thiago";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/.config/nix-config";
    avatar = config.var.homeDirectory + "/.profile-picture.jpeg";
    picturesDirectory = config.var.homeDirectory + "/Pictures";

    keyboardLayout = "us";
    keyboardVariant = "intl";
    location = "Belo Horizonte";
    timeZone = "America/Sao_Paulo";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "pt_BR.UTF-8";

    theme = import ../../themes/var/default.nix;
  };
}
