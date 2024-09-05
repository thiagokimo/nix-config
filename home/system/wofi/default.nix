{pkgs, ...}: {

  home.packages = [pkgs.wofi-emoji];

  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      show = "drun";
      prompt = "Apps";
      key_exit = "Escape";
      key_expand = "Tab";
      sort_order = "default";
    };
  };
}
