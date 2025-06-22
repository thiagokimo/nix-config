{config, ...}: {
  imports = [../../modules/nixos/variables-config.nix];

  config.var = {
    stateVersion = "25.05";

    username = "thiago";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/.config/nix-config";
  };
}
