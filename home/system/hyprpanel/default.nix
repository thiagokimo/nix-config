{
  pkgs,
  config,
  ...
}: let
  font = "${config.stylix.fonts.serif.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";
  rounding = config.var.theme.rounding;
  border-size = config.var.theme.border-size;
  gaps-out = config.var.theme.gaps-out;
  gaps-in = config.var.theme.gaps-in;
  location = config.var.location;
in {
  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.hyprpanel}/bin/hyprpanel"
  ];
  home.packages = with pkgs; [hyprpanel libnotify];
  home.file.".cache/ags/hyprpanel/options.json".text = ''
    {
      "bar.launcher.icon":"",
      "bar.workspaces.show_numbered": false,
      "scalingpriority":"hyprland",
      "tear":true,
      "menus.clock.weather.unit":"metric",
      "menus.clock.weather.location":"${location}",
      "menus.dashboard.shortcuts.left.shortcut1.icon":"",
      "menus.dashboard.shortcuts.left.shortcut1.command":"google-chrome-stable",
      "menus.dashboard.shortcuts.left.shortcut1.tooltip":"Google Chrome",
      "menus.dashboard.directories.left.directory1.label": "󰉍 Downloads",
      "menus.dashboard.directories.left.directory1.command": "bash -c \"thunar $HOME/Downloads/\"",
      "menus.dashboard.directories.left.directory2.label": "󰉏 Pictures",
      "menus.dashboard.directories.left.directory2.command": "bash -c \"thunar $HOME/Pictures/\"",
      "menus.dashboard.directories.left.directory3.label": "󱧶 Documents",
      "menus.dashboard.directories.left.directory3.command": "bash -c \"thunar $HOME/Documents/\"",
      "menus.dashboard.directories.right.directory1.label": "󱂵 Home",
      "menus.dashboard.directories.right.directory1.command": "bash -c \"thunar $HOME/\"",
      "menus.dashboard.directories.right.directory2.label": "󰚝 Projects",
      "menus.dashboard.directories.right.directory2.command": "bash -c \"thunar $HOME/Projects/\"",
      "menus.dashboard.directories.right.directory3.label": " Config",
      "menus.dashboard.directories.right.directory3.command": "bash -c \"thunar $HOME/.config/\"",
      "menus.dashboard.shortcuts.right.shortcut3.command":"hyprpicker -a",
      "menus.dashboard.shortcuts.left.shortcut4.command":"menu",
      "bar.layouts":{
        "*":{
          "left":[
            "dashboard",
            "workspaces"
          ],
          "middle":[
            "windowtitle"
          ],
          "right":[
            "volume",
            "network",
            "battery",
            "systray",
            "clock",
            "notifications"
          ]
        }
      },
      "theme.font.name": "${font}",
      "theme.font.size": "${fontSize}px"
    } 
  '';
 }
