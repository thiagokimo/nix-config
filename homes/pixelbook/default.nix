{pkgs, ...}: {

  imports = [
    ../../modules/home-manager
    ../../modules/home-manager/programs/cli
  ];

  home.stateVersion = "23.11";
}
