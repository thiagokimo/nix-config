{
  pkgs,
  lib,
  nixvim,
  ...
}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];

    extraConfig = ''
      syntax on
      set encoding=utf-8
      set number relativenumber
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
