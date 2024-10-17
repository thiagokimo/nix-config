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

    extraConfig = lib.fileContents ./init.vim;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
