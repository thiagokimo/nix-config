{
  programs.nixvim.plugins = {
    web-devicons.enable = true;

    lualine = {
      enable = true;

      settings = {
        options = {
          theme = "auto";
          icons_enabled = true;
          always_divide_middle = true;
        };
      };
    };
  };
}
