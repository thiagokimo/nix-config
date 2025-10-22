{outputs, configVars, ...}: {
  imports = [
    ../../modules/home/cli
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = with outputs.overlays; [
      additions
      modifications
      stable-packages
    ];
  };


  home = {
    username = "${configVars.username}";
    homeDirectory = "/home/${configVars.username}";
    stateVersion = "${configVars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
