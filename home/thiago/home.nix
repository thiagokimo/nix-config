{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./cli ./hypr ./scripts ./programs];

  home = {
    username = lib.mkDefault "thiago";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "25.05";
    packages = with pkgs; [
      google-chrome
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
