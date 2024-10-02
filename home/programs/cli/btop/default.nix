{
  programs.btop = {
    enable = true;
  };

  home.file = {
    ".config/btop/btop.conf" = {
      text = builtins.readFile ./btop.conf;
    };
    ".config/btop/themes/gruvbox_dark.theme" = {
      text = builtins.readFile ./gruvbox_dark.theme;
    };
  };
}
