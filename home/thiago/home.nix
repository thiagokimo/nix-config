{
  config,
  lib,
  pkgs,
  inputs,
  configVars,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix ./cli ./hypr ./scripts ./programs ./mime.nix ./stylix.nix];

  home = {
    username = lib.mkDefault "thiago";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = configVars.stateVersion;
    packages = with pkgs; [
      google-chrome
      kitty
      vlc
    ];
    sessionVariables = {};
    file = {};
  };
  programs.home-manager.enable = true;
}
