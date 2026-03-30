{
  pkgs,
  config,
  ...
}: let
  border-size = 3;
  gaps-in = 5;
  gaps-out = 10;
  active-opacity = 1;
  inactive-opacity = 0.89;
  rounding = 20;
  rounding-power = 2;
  blur = true;
  layout = "dwindle";

  # Noctalia's interface
  ipc = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call";
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$modShift" = "SUPER_SHIFT";

      exec-once = [
        "hyprpaper"
        "${pkgs.noctalia-shell}/bin/noctalia-shell"
      ];

      # TODO Figure out how a smarter way to isolate monitor setups for multiple hosts
      monitor = [
        # laptop monitor
        "eDP-1,preferred,auto,1"
        # home external monitor
        "DP-4,preferred,auto,1"
        # "desc:Samsung Electric Company LU28R55 HX5W901392,preferred,auto,1"
        # "desc:Samsung Electric Company LC34G55T H4ZT700047,preferred,auto,1"
      ];
      bind =
        [
          "$mod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
          "$mod, B, exec, ${pkgs.google-chrome}/bin/google-chrome-stable"
          "$mod, E, exec, ${pkgs.kitty}/bin/kitty -e ${pkgs.yazi}/bin/yazi"
          "$modShift, L, exec, ${ipc} lockScreen lock"
          "$mod, PRINT, exec, screenshot"
          "$modShift, PRINT, exec, screenshot-region"

          "$mod, SPACE, exec, ${ipc} launcher toggle"

          "$mod, Q, killactive"
          "$mod, T, togglefloating"
          "$mod, F, fullscreen"
          "$mod, J, layoutmsg, togglesplit"
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
        ",XF86AudioMute, exec, ${ipc} volute muteOutput"
        ",switch:Lid Switch, exec, ${ipc} lockScreen lock"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, ${ipc} volume increase"
        ", XF86AudioLowerVolume, exec, ${ipc} volume decrease"
        ", XF86MonBrightnessUp, exec, ${ipc} brightness increase"
        ", XF86MonBrightnessDown, exec, ${ipc} brightness decrease"
      ];

      env = [
        "AQ_NO_MODIFIERS,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland,xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      general = {
        gaps_in = gaps-in;
        gaps_out = gaps-out;
        border_size = border-size;
        resize_on_border = true;
        layout = layout;
      };

      decoration = {
        rounding = rounding;
        rounding_power = rounding-power;
        active_opacity = active-opacity;
        inactive_opacity = inactive-opacity;
        blur = {
          enabled = blur;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };
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
        kb_layout = "us";
        kb_variant = "intl";
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
    };
  };
}
