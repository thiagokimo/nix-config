{
  pkgs,
  config,
  ...
}: let
  font = "${config.stylix.fonts.serif.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";

  red = "#${config.lib.stylix.colors.base08}";
  orange = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  cyan = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  purple = "#${config.lib.stylix.colors.base0E}";
  brown = "#${config.lib.stylix.colors.base0F}";

  transparent = config.var.theme.bar.transparent;
  transparentButtons = config.var.theme.bar.transparentButtons;

  floating = config.var.theme.bar.floating;
  position = config.var.theme.bar.position;
  
  rounding = config.var.theme.rounding;
  border-size = config.var.theme.border-size;
  gaps-out = config.var.theme.gaps-out;
  gaps-in = config.var.theme.gaps-in;

  username = config.var.username;
  location = config.var.location;
in {
  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.hyprpanel}/bin/hyprpanel"
  ];
  home.packages = with pkgs; [hyprpanel libnotify];
  home.file.".cache/ags/hyprpanel/options.json".text = ''
    {
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
            "clock",
            "notifications"
          ]
        }
      },
      "bar.customModules.updates.pollingInterval": 1440000,
      "bar.launcher.icon":"",
      "bar.workspaces.show_numbered": false,
      "bar.workspaces.workspaces": 5,
      "menus.clock.weather.location":"${location}",
      "menus.clock.weather.unit":"metric",
      "menus.dashboard.directories.left.directory1.command": "bash -c \"thunar $HOME/Downloads/\"",
      "menus.dashboard.directories.left.directory1.label": "󰉍 Downloads",
      "menus.dashboard.directories.left.directory2.command": "bash -c \"thunar $HOME/Pictures/\"",
      "menus.dashboard.directories.left.directory2.label": "󰉏 Pictures",
      "menus.dashboard.directories.left.directory3.command": "bash -c \"thunar $HOME/Documents/\"",
      "menus.dashboard.directories.left.directory3.label": "󱧶 Documents",
      "menus.dashboard.directories.right.directory1.command": "bash -c \"thunar $HOME/\"",
      "menus.dashboard.directories.right.directory1.label": "󱂵 Home",
      "menus.dashboard.directories.right.directory2.command": "bash -c \"thunar $HOME/Projects/\"",
      "menus.dashboard.directories.right.directory2.label": "󰚝 Projects",
      "menus.dashboard.directories.right.directory3.command": "bash -c \"thunar $HOME/.config/\"",
      "menus.dashboard.directories.right.directory3.label": " Config",
      "menus.dashboard.powermenu.avatar.image": "/home/${username}/.profile-picture.jpeg",
      "menus.dashboard.shortcuts.left.shortcut1.command":"google-chrome-stable",
      "menus.dashboard.shortcuts.left.shortcut1.icon":"",
      "menus.dashboard.shortcuts.left.shortcut1.tooltip":"Google Chrome",
      "menus.dashboard.shortcuts.left.shortcut4.command":"menu",
      "menus.dashboard.shortcuts.right.shortcut3.command":"hyprpicker -a",
      "scalingpriority":"hyprland",
      "tear":true,
      "theme.bar.background": "${background + (if transparentButtons then "00" else "")}",
      "theme.bar.border_radius": "${toString rounding}px",
      "theme.bar.buttons.background": "${(if transparent then background else background-alt) + (if transparentButtons then "00" else "")}",
      "theme.bar.buttons.monochrome": true,
      "theme.bar.buttons.padding_x": "0.8rem",
      "theme.bar.buttons.padding_y": "0.4rem",
      "theme.bar.buttons.radius": "${if transparent then toString rounding else toString (rounding - 8)}px",
      "theme.bar.buttons.spacing": "0.3em",
      "theme.bar.buttons.style": "default",
      "theme.bar.buttons.workspaces.active": "${green}",
      "theme.bar.buttons.workspaces.available": "${blue}",
      "theme.bar.buttons.workspaces.hover": "${orange}",
      "theme.bar.buttons.workspaces.occupied": "${red}",
      "theme.bar.buttons.y_margins": "${if floating && transparent then "0" else "8"}px",
      "theme.bar.floating": ${if floating then "true" else "false"},
      "theme.bar.location": "${position}",
      "theme.bar.margin_bottom": "${if position == "top" then "0" else toString (gaps-in * 2)}px",
      "theme.bar.margin_sides": "${toString gaps-out}px",
      "theme.bar.margin_top": "${if position == "top" then toString (gaps-in * 2) else "0"}px",
      "theme.bar.menus.background": "${background}",
      "theme.bar.menus.border.radius": "${toString rounding}px",
      "theme.bar.menus.border.size": "${toString border-size}px",
      "theme.bar.menus.card_radius": "${toString rounding}px",
      "theme.bar.menus.cards": "${background-alt}",
      "theme.bar.menus.menu.media.card.tint": 90,
      "theme.bar.menus.monochrome": true,
      "theme.bar.outer_spacing": "${if floating && transparent then "0" else "8"}px",
      "theme.bar.transparent": ${if transparent then "true" else "false"},
      "theme.font.name": "${font}",
      "theme.font.size": "${fontSize}px",
      "theme.notification.border_radius": "${toString rounding}px",
      "theme.osd.enable": true,
      "theme.osd.location": "left",
      "theme.osd.margins": "0px 0px 0px 10px",
      "theme.osd.muted_zero": true,
      "theme.osd.orientation": "vertical",
      "theme.osd.radius": "${toString rounding}px",
      "wallpaper.enable": false
    } 
  '';
 }
