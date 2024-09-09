{config, ...}: {
  imports = [../modules/variables-config.nix];

  config.var = {
    stateVersion = "24.05";

    hostname = "nixos";
    username = "thiago";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/.config/nix-config";

    keyboardLayout = "us";
    keyboardVariant = "intl";
    location = "Belo Horizonte";
    timeZone = "America/Sao_Paulo";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "pt_BR.UTF-8";

    # TODO Add theme stuff later
  };
}
