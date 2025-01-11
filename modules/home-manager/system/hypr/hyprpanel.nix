{
  pkgs,
  config,
  inputs,
  ...
}: let
  font = "${config.stylix.fonts.serif.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

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
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    systemd.enable = true;
    theme = "monochrome";
    layout = {
      "bar.layouts" = {
        "*" = {
          "left" = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          "middle" = [];
          "right" = [
            "volume"
            "network"
            "battery"
            "clock"
            "notifications"
            "systray"
          ];
        };
      };
    };
    override = {
      "bar.customModules.updates.pollingInterval" = 1440000;
      "bar.launcher.icon" = "";
      "bar.workspaces.showWsIcons" = true;
      "bar.workspaces.show_numbered" = false;
      "bar.workspaces.workspaces" = 5;
      "menus.clock.weather.location" = "${location}";
      "menus.clock.weather.unit" = "metric";
      "menus.dashboard.directories.left.directory1.command" = "bash -c \"thunar $HOME/Downloads/\"";
      "menus.dashboard.directories.left.directory1.label" = "󰉍 Downloads";
      "menus.dashboard.directories.left.directory2.command" = "bash -c \"thunar $HOME/Pictures/\"";
      "menus.dashboard.directories.left.directory2.label" = "󰉏 Pictures";
      "menus.dashboard.directories.left.directory3.command" = "bash -c \"thunar $HOME/Documents/\"";
      "menus.dashboard.directories.left.directory3.label" = "󱧶 Documents";
      "menus.dashboard.directories.right.directory1.command" = "bash -c \"thunar $HOME/\"";
      "menus.dashboard.directories.right.directory1.label" = "󱂵 Home";
      "menus.dashboard.directories.right.directory2.command" = "bash -c \"thunar $HOME/Projects/\"";
      "menus.dashboard.directories.right.directory2.label" = "󰚝 Projects";
      "menus.dashboard.directories.right.directory3.command" = "bash -c \"thunar $HOME/.config/\"";
      "menus.dashboard.directories.right.directory3.label" = " Config";
      "menus.dashboard.powermenu.avatar.image" = "/home/${username}/.profile-picture.jpeg";
      "menus.dashboard.shortcuts.left.shortcut1.command" = "google-chrome-stable";
      "menus.dashboard.shortcuts.left.shortcut1.icon" = "";
      "menus.dashboard.shortcuts.left.shortcut1.tooltip" = "Google Chrome";
      "menus.dashboard.shortcuts.left.shortcut4.command" = "app-launcher";
      "menus.dashboard.shortcuts.left.shortcut4.icon" = "";
      "menus.dashboard.shortcuts.left.shortcut4.tooltip" = "Launch App";
      "menus.dashboard.shortcuts.right.shortcut1.command" = "sleep 0.5 && hyprpicker -a";
      "menus.dashboard.shortcuts.right.shortcut1.icon" = "";
      "menus.dashboard.shortcuts.right.shortcut1.tooltip" = "Color Picker";
      "menus.dashboard.shortcuts.right.shortcut3.command" = "screenshot";
      "menus.dashboard.shortcuts.right.shortcut3.icon" = "󰄀";
      "menus.dashboard.shortcuts.right.shortcut3.tooltip" = "Take screenshot";
      "scalingPriority" = "hyprland";
      "tear" = true;
      "theme.bar.border_radius" = "${toString rounding}px";
      "theme.bar.buttons.background_opacity" = 50;
      "theme.bar.buttons.style" = "default";
      "theme.bar.location" = "${position}";
      "theme.bar.menus.border.radius" = "${toString rounding}px";
      "theme.bar.menus.border.size" = "${toString border-size}px";
      "theme.bar.menus.card_radius" = "${toString rounding}px";
      "theme.bar.opacity" = 35;
      "theme.font.name" = "${font}";
      "theme.font.size" = "${fontSize}px";
      "theme.notification.border_radius" = "${toString rounding}px";
      "theme.osd.enable" = true;
      "theme.osd.location" = "left";
      "theme.osd.margins" = "10px 10px 10px 10px";
      "theme.osd.muted_zero" = true;
      "theme.osd.orientation" = "vertical";
      "theme.osd.radius" = "${toString rounding}px";
      "wallpaper.enable" = false;
    };
  };
}
