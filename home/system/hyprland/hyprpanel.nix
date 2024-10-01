{
  pkgs,
  config,
  ...
}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.hyprpanel}/bin/hyprpanel"
  ];

  home.packages = with pkgs; [hyprpanel libnotify];

  home.file.".cache/ags/hyprpanel/options.json" = {
    text = ''
      {
        "bar.layouts" = {
          "*": {
            "left": [
              "dashboard",
              "workspaces",
            ],
            "middle": [
              "windowtitle"
            ],
            "right": [
              "systray",
              "network",
              "volume",
              "battery",
              "clock"
              "notifications"
            ]
          }
        },
        "bar.launcher.icon": "",
      }
    '';
  };
}
