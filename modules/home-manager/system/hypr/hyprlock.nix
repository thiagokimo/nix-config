{config, ...}: let
  imageStr = toString config.stylix.image;
  font = config.stylix.fonts.serif.name;

  avatar = config.var.avatar;
  textColor = "#${config.lib.stylix.colors.base07}";
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
      # image = [
      #   {
      #     path = avatar;
      #     size = 150;
      #     border_size = 4;
      #     border_color = "rgb(0C96F9)";
      #     rounding = -1; # Negative means circle
      #     position = "0, -300";
      #     halign = "center";
      #     valign = "center";
      #   }
      # ];
      input-field = {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 5;
        placeholder_text = "Password...";
        shadow_passes = 2;
      };
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %Y - %B - %d")"'';
          color = textColor;
          font_size = 28;
          font_family = "${font} Bold";
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = textColor;
          font_size = 160;
          font_family = "${font}";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # {
        #   monitor = "";
        #   text = "    $USER";
        #   color = textColor;
        #   outline_thickness = 2;
        #   dots_size = 0.2;
        #   dots_spacing = 0.2;
        #   dots_center = true;
        #   font_size = 28;
        #   font_family ="${font} Bold";
        #   position = "0, -180";
        #   halign = "center";
        #   valign = "center";
        # }
      ];
    };
  };
}
