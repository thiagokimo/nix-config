{
  pkgs,
  config,
  ...
}: let
  border-size = config.var.theme.border-size;
  gaps-in = config.var.theme.gaps-in;
  gaps-out = config.var.theme.gaps-out;
  active-opacity = config.var.theme.active-opacity;
  inactive-opacity = config.var.theme.inactive-opacity;
  rounding = config.var.theme.rounding;
  blur = config.var.theme.blur;
  layout = "dwindle";
in {
  home.packages = with pkgs; [
    hyprpicker
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$modShift" = "SUPER_SHIFT";

      exec-once = ["hyprpaper"];

      monitor = ["eDP-1,2256x1504@60,auto,1"];
      bind =
        [
          "$mod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
          "$mod, B, exec, ${pkgs.google-chrome}/bin/google-chrome-stable"
          "$mod, E, exec, ${pkgs.xfce.thunar}/bin/thunar"
          "$modShift, L, exec, ${pkgs.hyprlock}/bin/hyprlock"

          "$mod, SPACE, exec, menu"

          "$mod, Q, killactive"
          "$mod, T, togglefloating"
          "$mod, F, fullscreen"
          "$mod, J, togglesplit"
          "$mod, N, movetoworkspace, special:minimized"
          "$mod, M, movetoworkspace, +0"
          "$mod, M, togglespecialworkspace, minimized"
          "$modShift, R, exec, hyprctl reload"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$modShift, left, layoutmsg, addmaster"
          "$modShift, right, layoutmsg, removemaster"
        ]
        ++ (builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$modShift, code:1${toString i}, movetoworkspace, ${toString ws}"
          ])
          9));

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        ",XF86AudioMute, exec, sound-toggle"
        ",switch:Lid Switch, exec, lock"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, sound-up"
        ", XF86AudioLowerVolume, exec, sound-down"
        ", XF86MonBrightnessUp, exec, brightness-up"
        ", XF86MonBrightnessDown, exec, brightness-down"
      ];

      env = [
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland,xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      general = {
        gaps_in = gaps-in;
        gaps_out = gaps-out;
        border_size = border-size;
        resize_on_border = true;
        border_part_of_window = true;
        layout = layout;
      };

      decoration = {
        rounding = rounding;
        active_opacity = active-opacity;
        inactive_opacity = inactive-opacity;
        blur = {enabled = blur;};
      };

      animations = {
        enabled = true;
        bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.5;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      input = {
        kb_layout = "${config.var.keyboardLayout}";
        kb_variant = "${config.var.keyboardVariant}";
        follow_mouse = true;
        sensitivity = 0.5;
        repeat_delay = 300;
        repeat_rate = 50;

        touchpad = {
          natural_scroll = true;
        };
      };

      cursor = {
        no_hardware_cursors = true;
      };

      gestures = {
        workspace_swipe = false;
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    };
  };
}
