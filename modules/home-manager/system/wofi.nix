{
  pkgs,
  config,
  lib,
  ...
}: let
  font = config.stylix.fonts.serif.name;
  font-size = config.stylix.fonts.sizes.popups;
  rounding = config.var.theme.rounding;
in {
  home.packages = [pkgs.wofi-emoji];

  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      allow_markup = true;
      dynamic_lines = false;
      exec_search = false;
      halign = "fill";
      hide_scroll = true;
      hide_search = false;
      image_size = 24;
      insensitive = true;
      key_exit = "Escape";
      key_expand = "Tab";
      layer = "top";
      line_wrap = "off";
      no_actions = true;
      normal_window = true;
      orientation = "vertical";
      parse_search = false;
      prompt = "Apps";
      show = "drun";
      sort_order = "default";
      term = "foot";
    };

    style = lib.mkForce ''
      * {
        font-family: "${font}";
        font-weight: 500;
        font-size: ${toString font-size}px;
      }

      #window {
        border-radius: ${toString rounding}px;
      }

      #unselected {}

      #selected {}

      #img {
        padding-right: 8px;
      }

      #inner-box {}

      #outer-box {
        padding: 20px;
      }

      #entry {
        padding: 6px;
      }

      #entry:selected {
        border-radius: ${toString rounding}px;
      }

      #input {
        border-radius: ${toString rounding}px;
        padding: 8px 12px;
      }

      #input:focus {}

      #scroll {
        margin-top: 20px;
      }
    '';
  };
}
