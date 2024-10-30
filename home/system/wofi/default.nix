{
  pkgs,
  config,
  lib,
  ...
}: let
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

    style = with config.lib.stylix.colors; lib.mkForce ''
      
      * {
        font-family: "${font}";
        font-weight: 500;
        font-size: ${toString font-size}px;
      }

      #window {
        background-color: ${base00};
        color: ${base05};
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

      #entry:nth-child(odd) {
        background-color: ${base00};
      }

      #entry:nth-child(even) {
        background-color: ${base01};
      }

      #entry:selected {
        background-color: ${base02};
        border-radius: ${toString rounding}px;
      }

      #input {
        background-color: ${base01};
        color: ${base04};
        border-radius: ${toString rounding}px;
        border-color: ${base02};
        padding: 8px 12px;
      }

      #input:focus {
        border-color: ${base0A};
      }

      #scroll {
        margin-top: 20px;
      }
    '';
  };
}
