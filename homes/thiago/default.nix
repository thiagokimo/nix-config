{pkgs, ...}: {
  imports = [
    ../../modules/home-manager
    ../../modules/home-manager/programs/cli
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
