{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ../features/cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "thiago";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";
    sessionPath = ["$HOME/.local.bin"];

    persistence = {
      "/persist/${config.home.homeDirectory}" = {
        defaultDirectoryMethod = "symlink";
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          "Projects"
          ".local.bin"
        ];
        allowOther = true;
      };
    };
  };
}
