{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../variables.nix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      configVars = config.var;
    };

    users.thiago = {
      imports = [../../../home/thiago/home.nix];
      home.username = "thiago";
      home.homeDirectory = "/home/thiago";
      home.stateVersion = config.var.stateVersion;
      programs.home-manager.enable = true;
    };
  };
}
