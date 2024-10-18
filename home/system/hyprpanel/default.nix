{
  pkgs,
  config,
  ...
}: let
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  font = "${config.stylix.fonts.serif.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

  rounding = config.var.theme.rounding;
  border-size = config.var.theme.border-size;

  gaps-out = config.var.theme.gaps-out;
  gaps-in = config.var.theme.gaps-in;

  location = config.var.theme.location;
in {
  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.hyprpanel}/bin/hyprpanel"
  ];

  home.packages = with pkgs; [hyprpanel libnotify];

  home.file.".cache/ags/hyprpanel/options.json".text = ''
    {
      "bar.layouts": {
        "*": {
          "left": [
            "dashboard",
            "workspaces"
          ],
          "middle":[
            "windowtitle"
          ],
          "right": [
            "volume",
            "network",
            "bettery",
            "systray",
            "clock",
            "notifications"
          ]
        }
      },
      "bar.launcher.icon": "",
      "bar.workspaces.show_numbered": false,
      "bar.workspaces.workspaces": 5,
      "bar.workspaces.hideUnoccupied": false,
      "bar.windowtitle.label": true,
      "bar.volume.label": false,
      "bar.network.truncation_size": 12,
      "bar.bluetooth.label": false,
      "bar.clock.format": "%a %b %d  %I:%M %p",
      "bar.notifications.show_total": true,
      "theme.notification.border_radius": "${toString rounding}px",
      "theme.osd.enable": true,
      "theme.osd.orientation": "vertical",
      "theme.osd.location": "left",
      "theme.osd.radius": "${toString rounding}px",
      "theme.osd.margins": "0px 0px 0px 10px",
      "theme.osd.muted_zero": true,

      "scalingPriority": "hyprland",
      "tear": true,

      "menus.clock.weather.unit": "metric",
      "menus.clock.weather.location": "${location}",

      "menus.dashboard.shortcuts.left.shortcut1.icon": "",
      "menus.dashboard.shortcuts.left.shortcut1.command": "google-chrome-stable",
      "menus.dashboard.shortcuts.left.shortcut1.tooltip": "Google Chrome",
      "menus.dashboard.directories.left.directory1.command": "bash -c \"thunar $HOME/Downloads/\"",
      "menus.dashboard.directories.left.directory2.command": "bash -c \"thunar $HOME/Videos/\"",
      "menus.dashboard.directories.left.directory3.command": "bash -c \"thunar $HOME/Projects/\"",
      "menus.dashboard.directories.right.directory1.command": "bash -c \"thunar $HOME/Documents/\"",
      "menus.dashboard.directories.right.directory2.command": "bash -c \"thunar $HOME/Pictures/\"",
      "menus.dashboard.directories.right.directory3.command": "bash -c \"thunar $HOME/\"",
      "menus.dashboard.shortcuts.right.shortcut3.command": "hyprpicker -a",
      "menus.dashboard.shortcuts.left.shortcut4.command": "menu",

      "theme.font.name": "${font}",
      "theme.font.size": "${fontSize}px",

      "theme.bar.outer_spacing": "8px",
      "theme.bar.buttons.y_margins": "8px",
      "theme.bar.buttons.spacing": "0.3em",
      "theme.bar.buttons.radius": "${toString (rounding -8)}px",
      "theme.bar.buttons.padding_x": "0.8rem",
      "theme.bar.buttons.padding_y": "0.4rem",
      "theme.bar.buttons.workspaces.hover": "${accent-alt}",
      "theme.bar.buttons.workspaces.active": "${accent}",
      "theme.bar.buttons.workspaces.available": "${background}",
      "theme.bar.margin_top": "${toString (gaps-in * 2)}px",
      "theme.bar.margin_sides": "${toString gaps-out}px",
      "theme.bar.margin_bottom": "0px",
      "theme.bar.border_radius": "${toString rounding}px",
      "theme.bar.buttons.battery.enableBorder": false
      "theme.bar.floating": true,
      "theme.bar.location": "top",
      "theme.bar.menus.monochrome": true,
      "wallpaper.enable": false,
      "theme.bar.menus.background": "${background}",
      "theme.bar.menus.cards": "${background-alt}",
      "theme.bar.menus.card_radius": "${toString rounding}px",
      "theme.bar.menus.label": "${foreground}",
      "theme.bar.menus.text": "${foreground}",
      "theme.bar.menus.border.size": "${toString border-size}px",
      "theme.bar.menus.border.color": "${accent}",
      "theme.bar.menus.border.radius": "${toString rounding}px",
      "theme.bar.menus.popover.text": "${foreground}",
      "theme.bar.menus.popover.background": "${background-alt}",
      "theme.bar.menus.listitems.active": "${accent}",
      "theme.bar.menus.icons.active": "${accent}",
      "theme.bar.menus.switch.enabled":"${accent}",
      "theme.bar.menus.check_radio_button.active": "${accent}",
      "theme.bar.menus.buttons.default": "${accent}",
      "theme.bar.menus.buttons.active": "${accent}",
      "theme.bar.menus.iconbuttons.active": "${accent}",
      "theme.bar.menus.progressbar.foreground": "${accent}",
      "theme.bar.menus.slider.primary": "${accent}",
      "theme.bar.menus.tooltip.background": "${background-alt}",
      "theme.bar.menus.tooltip.text": "${foreground}",
      "theme.bar.menus.dropdownmenu.background":"${background-alt}",
      "theme.bar.menus.dropdownmenu.text": "${foreground}",
      "theme.bar.background": "",
      "theme.bar.buttons.style": "default",
      "theme.bar.buttons.monochrome": true,
      "theme.bar.buttons.text": "${foreground}",
      "theme.bar.buttons.background": "${background-alt}",
      "theme.bar.buttons.icon": "${accent}",
      "theme.bar.buttons.notifications.background": "${background-alt}",
      "theme.bar.buttons.hover": "${background}",
      "theme.bar.buttons.notifications.hover": "${background}",
      "theme.bar.buttons.notifications.total": "${accent}",
      "theme.bar.buttons.notifications.icon": "${accent}",
      "theme.notification.background": "${background-alt}",
      "theme.notification.actions.background": "${accent}",
      "theme.notification.actions.text": "${foreground}",
      "theme.notification.label": "${accent}",
      "theme.notification.border": "${background-alt}",
      "theme.notification.text": "${foreground}",
      "theme.notification.labelicon": "${accent}",
      "theme.osd.bar_color": "${accent}",
      "theme.osd.bar_overflow_color": "${accent-alt}",
      "theme.osd.icon": "${background}",
      "theme.osd.icon_container": "${accent}",
      "theme.osd.label": "${accent}",
      "theme.osd.bar_container": "${background-alt}",
      "theme.bar.menus.menu.media.background.color": "${background-alt}",
      "theme.bar.menus.menu.media.card.color": "${background-alt}",
      "theme.bar.menus.menu.media.card.tint": 90,
      "bar.customModules.updates.pollingInterval": 1440000,
      "bar.media.show_active_only": true
    }
  '';
  # home.file.".cache/ags/hyprpanel/options.json" = {
  #   text = builtins.readFile ./options.json;
  # };
}
