{
  # TODO Fix the way to open the terminal according to the main terminal
  # instead of assuming kitty is installed
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "custom/launcher"
        "backlight"
        "wireplumber"
        "cpu"
        "mpris"
      ];
      modules-center = [
        "hyprland/workspaces"
        "clock"
      ];

      modules-right = [
        "wlr/taskbar"
        "bluetooth"
        "network"
        "memory"
        "tray"
        "battery"
      ];

      "custom/launcher" = {
        format = " ";
        on-click = "app-launcher";
      };
      "backlight" = {
        device = "intel_backlight";
        rotate = 0;
        format = "{icon} {percent}%";
        format-icons = "";
        on-scroll-up = "brightnessctl set 1%+";
        on-scroll-down = "brightnessctl set 1$-";
        min-length = 6;
      };
      "hyprland/workspaces" = {
        separate-outputs = false;
        active-only = false;
        disable-scroll = false;
        all-outputs = true;
        format = "{icon}";
        on-click = "activate";
        sort-by-number = true;

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
          "10" = "10";
        };
      };
      # "temperature" = {
      #   format = "{icon} {temperatureC}°C ";
      #   tooltip = false;
      #   critical-threshold = 80;
      #   format-icons = ["" "" ""];
      # };
      "tray" = {
        icon-size = 16;
        rotate = 0;
        spacing = 5;
      };
      "hyprland/window" = {
        format = "{initialTitle}";
        icon = true;
        icon-size = 16;
      };
      "wireplumber" = {
        tooltip = false;
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
        rotate = 0;
        format-ethernet = "󰈀 ";
        format-disconnected = "󰖪 ";
        on-click = "kitty --class nmtui -e nmtui";
        tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
        format-linked = "󰈀 {ifname} (No IP)";
        tooltip-format-disconnected = "Disconnected";
        interval = 2;
      };
      "cpu" = {
        format = "  {usage}%";
        interval = 1;
        tooltip = false;
        on-click = "kitty --class btop -e btop";
      };
      "memory" = {
        interval = 30;
        format = "  {used:0.1f}G/{total:0.1f}G%";
        max-length = 20;
        tooltip = false;
      };

      "battery" = {
        interval = 1;
        states = {
          good = 95;
          warning = 30;
          critical = 20;
        };
        format = "{icon} {capacity}%";
        rotate = 0;
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{time} {icon}";
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      };
      "clock" = {
        format = " 󰸗 {:%I:%M %p} ";
        interval = 60;
        tooltip = true;
        tooltip-format = "{:%d %B %H:%M}";
      };
      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 16;
        icon-theme = "Gruvbox-Dark-Hard";
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
        ignore-list = ["kitty"];
        # app_ids-mapping = {};
        markup = true;
        all-outputs = false;
      };
    };
  };
}
