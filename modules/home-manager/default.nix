{
  lib,
  config,
  outputs,
  ...
}: {
  programs.home-manager.enable = true;

  home = {
    username = lib.mkDefault "thiago";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
    stateVersion = "23.11";
  };
}
