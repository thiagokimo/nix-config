{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
    ];

    # TODO Add config files later
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
