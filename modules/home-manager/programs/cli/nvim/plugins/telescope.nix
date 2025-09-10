{pkgs, ...}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings.defaults = {
      layout_strategy = "horizontal";
      sorting_strategy = "descending";
    };
    extensions = {
      fzf-native.enable = true;
    };
  };
}
