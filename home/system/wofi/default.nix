{
  pkgs,
  config,
  lib,
  ...
}: let
  accent = "#${config.lib.stylix.colors.base0D}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  font = config.stylix.fonts.serif.name;
  rounding = config.var.theme.rounding;
  font-size = config.stylix.fonts.sizes.popups;
in {
  home.packages = [pkgs.wofi-emoji];

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
    style = ''
      * {
        font-family: "${font}";
        font-weight: 500;
        font-size: ${toString font-size}px;
      }

      #window {
        background-color: ${background};
        color: ${foreground};
        border-radius: ${toString rounding}px;
      }

      #outer-box {
        padding: 20px;
      }

      #input {
        background-color: ${background-alt};
        border: 0px solid ${accent};
        color: ${foreground};
        padding: 8px 12px;
      }

      #scroll {
        margin-top: 20px;
      }

      #inner-box {}

      #img {
        padding-right: 8px;
      }

      #text {
        color: ${foreground};
      }

      #text:selected {
        color: ${foreground};
      }

      #entry {
        padding: 6px;
      }

      #entry:selected {
        background-color: ${accent};
        color: ${foreground};
      }

      #unselected {}

      #selected {}

      #input,
      #entry:selected {
        border-radius: ${toString rounding}px;
      }
    '';
  };
}
