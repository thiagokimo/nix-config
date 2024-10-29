{
  pkgs,
  config,
  ...
}: let
  font = "${config.stylix.fonts.serif.name}";
  fontsize = "${toString config.stylix.fonts.sizes.desktop}";
  rounding = config.var.theme.rounding;
  border-size = config.var.theme.border-size;
  gaps-out = config.var.theme.gaps-out;
  gaps-in = config.var.theme.gaps-in;
  location = config.var.location;
  wallpaper = config.stylix.image;
in {
  wayland.windowmanager.hyprland.settings.exec-once = [
    "${pkgs.hyprpanel}/bin/hyprpanel"
  ];
  home.packages = with pkgs; [hyprpanel libnotify];
  home.file.".cache/ags/hyprpanel/options.json".text = ''
    {
      "bar.custommodules.updates.pollinginterval":1440000,
      "bar.launcher.icon":"",
      "bar.workspaces.show_numbered": false,
      "scalingpriority":"hyprland",
      "tear":true,
      "menus.clock.weather.unit":"metric",
      "menus.clock.weather.location":"${location}",
      "menus.dashboard.shortcuts.left.shortcut1.icon":"",
      "menus.dashboard.shortcuts.left.shortcut1.command":"google-chrome-stable",
      "menus.dashboard.shortcuts.left.shortcut1.tooltip":"google chrome",
      "menus.dashboard.directories.left.directory1.command":"bash -c \"thunar $home/downloads/\"",
      "menus.dashboard.directories.left.directory2.command":"bash -c \"thunar $home/videos/\"",
      "menus.dashboard.directories.left.directory3.command":"bash -c \"thunar $home/projects/\"",
      "menus.dashboard.directories.right.directory1.command":"bash -c \"thunar $home/documents/\"",
      "menus.dashboard.directories.right.directory2.command":"bash -c \"thunar $home/pictures/\"",
      "menus.dashboard.directories.right.directory3.command":"bash -c \"thunar $home/\"",
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
      "wallpaper.image": "${wallpaper}",
      "theme.font.name": "${font}",
      "theme.font.size": "${fontsize}px",
      "theme.matugen": true,
      "theme.matugen_settings.mode": "dark",
      "theme.matugen_settings.scheme_type": "tonal-spot",
      "theme.matugen_settings.variation": "standard_1"
    } 
  '';
 }
