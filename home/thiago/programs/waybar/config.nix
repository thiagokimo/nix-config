{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 0;
      margin-top = 5;
      margin-left = 100;
      margin-bottom = 0;
      margin-right = 100;

      modules-left = [
        "clock"
        "hyprland/workspaces"
      ];
      modules-center = [];
      modules-right = [
        "wireplumber"
        "bluetooth"
        "network"
        "cpu"
        "memory"
        "battery"
      ];
      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = false;
        all-outputs = true;
        format = "{icon}";
        on-click = "activate";

        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };

        format-icons = {
          "1" = "일";
          "2" = "이";
          "3" = "삼";
          "4" = "사";
          "5" = "오";
          "6" = "육";
          "7" = "칠";
          "8" = "팔";
          "9" = "구";
        };
      };
      "wireplumber" = {
        format = "{volume}% {icon}";
        format-muted = "󰝟 ";
        format-icons = {
          default = ["" " " " "];
        };
        on-click = "sound-toggle";
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
        format = "{usage}%  ";
        interval = 1;
      };
      "memory" = {
        interval = 1;
        format = "{}%  ";
      };

      "battery" = {
        interval = 1;
        states = {
          good = 90;
          warning = 15;
          critical = 5;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-icons = [" " " " " " " " " "];
      };
      "clock" = {
        format = "{:%a/%d/%m │ %I:%M}";
       tooltip-format = "{:%B - %Y}";
      };
    };
  };
}
