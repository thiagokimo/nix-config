{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
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
