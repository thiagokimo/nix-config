{config, ...}: let
  imageStr = toString config.stylix.image;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 0;
        hide_cursor = false;
        no_fade_in = true;
        no_fade_out = true;
      };
      background = {
        monitor = "";
        path = imageStr;
        blur_passes = 2;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };
      label =[
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(255, 255, 255, 0.75)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = color;
          rounding = -1;
          placeholder_text = "<i>🔒 Enter Password</i>";
          hide_input = false;
          position = "0, -250";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
