{
  config,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
    users.${config.var.username} = {
      home.username = config.var.username;
      home.homeDirectory = config.var.homeDirectory;
      home.stateVersion = config.var.stateVersion;
      programs.home-manager.enable = true;
    };
  };
}
