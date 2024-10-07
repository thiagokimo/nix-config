{pkgs, ...}: {
  home.packages = [pkgs.wofi-emoji];

  home.file.".config/wofi/style.css" = {
    text = builtins.readFile ./style.css;
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      show = "drun";
      prompt = "Apps";
      normal_window = true;
      layer = "top";
      term = "foot";
      orientation = "vertical";
      halign = "fill";
      line_wrap = "off";
      dynamic_lines = false;
      allow_images = true;
      image_size = 24;
      exec_search = false;
      hide_search = false;
      parse_search = false;
      insensitive = true;
      hide_scroll = true;
      no_actions = true;
      key_exit = "Escape";
      key_expand = "Tab";
      sort_order = "default";
    };
  };
}
