{config, ...}: let
  imageStr = toString config.stylix.image;
  color = "rgba(216, 222, 233, 0.70)";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        no_fade_in = false;
        disable_loading_bar = false;
      };
      background = {
        monitor = "";
        path = imageStr;
        blur_passes = 0;
        contrast = 0.8916;
        brightness = 0.7172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = color;
          font_size = 28;
          position = "0, 490";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = color;
          font_size = 160;
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "    $USER";
          color = color;
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          font_size = 18;
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(255, 255, 255, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = color;
          fade_on_empty = false;
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
