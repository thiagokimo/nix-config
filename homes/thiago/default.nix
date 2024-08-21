{username, ...}: {

  imports = [
    ../../modules/home-manager/programs/cli
    ./nixpkgs.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "vim";
    };

    stateVersion = "24.05";
  };
  
  programs.home-manager.enable = true;
}
