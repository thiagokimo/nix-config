{inputs,...}:{
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
    users.thiago = {
      home.username = "thiago";
      home.homeDirectory = "/home/thiago";
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };
}
