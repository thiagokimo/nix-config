{configVars, ...}:{
  imports = [
    ../../modules/home/cli
  ];

  home = {
    username = "${configVars.username}";
    homeDirectory = "/home/${configVars.username}";
  };

  programs.home-manager.enable = true;
}
