{configVars, ...}: {
  imports = [
    ../../modules/home/cli
  ];

  home = {
    username = "${configVars.username}";
    homeDirectory = "/home/${configVars.username}";
    stateVersion = "${configVars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
