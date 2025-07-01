{
  programs.nixvim.plugins = {
    enable = true;
    defaults = {
      layout_strategy = "horizontal";
      sorting_strategy = "descending";
    };
    extensions = {
      fzf = {
        enable = true;
      };
    };
  };
}
