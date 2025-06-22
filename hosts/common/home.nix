{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/programs/cli
    ../../modules/home-manager/programs/dev
    ../../modules/home-manager/scripts/nix-kimo.nix
    ./variables.nix
  ];

  home = {
    inherit (config.var) username;
    inherit (config.var) homeDirectory;
    inherit (config.var) stateVersion;
  };

  programs.home-manager.enable = true;
}
