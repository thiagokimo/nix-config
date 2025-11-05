{
  # TODO Fix the way to open the terminal according to the main terminal
  # instead of assuming kitty is installed
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      
      modules-left = [
        "clock"
        "custom/separator"
        "hyprland/workspaces"
        "custom/separator"
        "tray"
      ];
      modules-center = ["hyprland/window"];

      modules-right = [
        "temperature"
        "memory"
        "cpu"
        "wireplumber"
        "bluetooth"
        "battery"
        "network"
        "custom/separator"
        "custom/powermenu"
      ];
      "hyprland/workspaces" = {
        separate-outputs = false;
        active-only = false;
        disable-scroll = false;
        all-outputs = true;
        format = "{icon}";
        on-click = "activate";
        
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
        };
      };
      "temperature" = {
        format = "{icon} {temperatureC}°C ";
        tooltip = false;
        critical-threshold = 80;
        format-icons = ["" "" ""];
      };
      "tray" = {
        icon-size = 16;
        spacing = 8;
      };
      "hyprland/window" = {
        format = "{initialTitle}";
        icon = true;
        icon-size = 16;
      };
      "wireplumber" = {
        format = "{icon} {volume}%";
        format-muted = "  {volume}%";
        format-icons = {
          default = ["" " " " "];
        };
        on-click = "sound-toggle";
        on-click-right = "kitty --class wiremix -e wiremix";
      };
      "bluetooth" = {
        format = "󰂲";
        format-on = "";
        format-connected = " {num_connections}";
        tooltip-format = "{status}";
        tooltip-format-on = "{status}";
        tooltip-format-connected = "{device_alias}";
        on-click = "kitty --class bluetui -e bluetui";
        interval = 1;
      };
      "network" = {
        format-wifi = " ";
        format-disconnected = "⚠";
        on-click = "kitty --class nmtui -e nmtui";
        tooltip-format = "{essid}";
      };
      "cpu" = {
        format = "  {usage}%";
        interval = 1;
        tooltip = false;
      };
      "memory" = {
        interval = 1;
        format = "  {}%";
        tooltip = false;
      };

      "battery" = {
        interval = 1;
        states = {
          good = 90;
          warning = 15;
          critical = 5;
        };
        format = "{icon} {capacity}%";
        format-full = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [" " " " " " " " " "];
      };
      "clock" = {
        format = " 󰸗 {:%I:%M %p} ";
        interval = 60;
        tooltip = true;
        tooltip-format = "{:%d %B %H:%M}";
      };
      "custom/powermenu" = {
        format = "  ";
        tooltip = false;
        # on-click = "exec wlogout -p layer-shell";
      };
      "custom/separator" = {
        format = "|";
        interval = "once";
        tooltip = false;
      };
    };
  };
}
