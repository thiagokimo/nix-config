{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    username = lib.mkDefault "thiago";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "25.05";
    packages = with pkgs; [
      firefox
      neovim
      kitty 
      vlc
      wofi
    ];
    sessionVariables = {};
    file = {};
  };
  programs.home-manager.enable = true;
}
