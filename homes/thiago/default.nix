{username, ...}: {
  imports = [
    ../../modules/home-manager/programs/cli
    ../../modules/home-manager/scripts
    ./nixpkgs.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
