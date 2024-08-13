{pkgs, ...}: {
  imports = [
    ../../modules/home-manager
    ../../modules/home-manager/programs/cli
    ../../modules/home-manager/programs/utility
  ];

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
