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
      gruvbox
    ];

    extraConfig = lib.fileContents ./vim/init.vim;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
