{
  pkgs,
  config,
  lib,
  ...
}: let
  # decoration vars
  border-size = 3;
  gaps-in = 5;
  gaps-out = 10;
  active-opacity = 1;
  inactive-opacity = 0.89;
  rounding = 20;
  rounding-power = 2;
  blur = true;
  layout = "dwindle";

  # noctalia's interface
  ipc = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call";

  envs = [
    {
      name = "AQ_NO_MODIFIERS";
      value = "1";
    }
    {
      name = "ELECTRON_OZONE_PLATFORM_HINT";
      value = "auto";
    }
    {
      name = "NIXOS_OZONE_WL";
      value = "1";
    }
    {
      name = "QT_AUTO_SCREEN_SCALE_FACTOR";
      value = "1";
    }
    {
      name = "QT_QPA_PLATFORM";
      value = "wayland;xcb";
    }
    {
      name = "QT_WAYLAND_DISABLE_WINDOWDECORATION";
      value = "1";
    }
    {
      name = "XDG_CURRENT_DESKTOP";
      value = "Hyprland";
    }
    {
      name = "XDG_SESSION_DESKTOP";
      value = "Hyprland";
    }
    {
      name = "XDG_SESSION_TYPE";
      value = "wayland";
    }
  ];

  keyBindings = [
    # helpers
    {
      mod = "SUPER + SHIFT";
      key = "R";
      dsp = "hl.dsp.exec_cmd('hyprctl reload')";
    }

    # apps
    {
      mod = "SUPER";
      key = "RETURN";
      dsp = "hl.dsp.exec_cmd('${pkgs.kitty}/bin/kitty')";
    }
    {
      mod = "SUPER";
      key = "B";
      dsp = "hl.dsp.exec_cmd('${pkgs.google-chrome}/bin/google-chrome-stable')";
    }
    {
      mod = "SUPER";
      key = "E";
      dsp = "hl.dsp.exec_cmd('${pkgs.kitty}/bin/kitty -e ${pkgs.yazi}/bin/yazi')";
    }
    {
      mod = "SUPER + SHIFT";
      key = "L";
      dsp = "hl.dsp.exec_cmd('${ipc} lockScreen lock')";
    }
    {
      mod = "SUPER";
      key = "PRINT";
      dsp = "hl.dsp.exec_cmd('screenshot')";
    }
    {
      mod = "SUPER + SHIFT";
      key = "PRINT";
      dsp = "hl.dsp.exec_cmd('screenshot-region')";
    }
    {
      mod = "SUPER";
      key = "SPACE";
      dsp = "hl.dsp.exec_cmd('${ipc} launcher toggle')";
    }

    # windows and workspaces
    {
      mod = "SUPER";
      key = "Q";
      dsp = "hl.dsp.window.close()";
    }
    {
      mod = "SUPER";
      key = "T";
      dsp = "hl.dsp.window.float({action = 'toggle'})";
    }
    {
      mod = "SUPER";
      key = "F";
      dsp = "hl.dsp.window.fullscreen({action = 'toggle'})";
    }
    {
      mod = "SUPER";
      key = "J";
      dsp = "hl.dsp.layout('togglesplit')";
    }
    {
      mod = "SUPER";
      key = "N";
      dsp = "hl.dsp.window.move({workspace = 'special:minimized'})";
    }
    {
      mod = "SUPER";
      key = "M";
      dsp = "hl.dsp.window.move({workspace = '+0'})";
    }
    {
      mod = "SUPER";
      key = "M";
      dsp = "hl.dsp.workspace.toggle_special('minimized')";
    }
    # focus
    {
      mod = "SUPER";
      key = "left";
      dsp = "hl.dsp.focus({direction = 'left'})";
    }
    {
      mod = "SUPER";
      key = "right";
      dsp = "hl.dsp.focus({direction = 'right'})";
    }
    {
      mod = "SUPER";
      key = "up";
      dsp = "hl.dsp.focus({direction = 'up'})";
    }
    {
      mod = "SUPER";
      key = "down";
      dsp = "hl.dsp.focus({direction = 'down'})";
    }

    # layout
    {
      mod = "SUPER + SHIFT";
      key = "left";
      dsp = "hl.dsp.layout('addmaster')";
    }
    {
      mod = "SUPER + SHIFT";
      key = "right";
      dsp = "hl.dsp.layout('removemaster')";
    }
  ];

  mouseBindings = [
    {
      mod = "SUPER";
      btn = "mouse:272";
      dsp = "hl.dsp.window.drag()";
    }
    {
      mod = "SUPER";
      btn = "mouse:273";
      dsp = "hl.dsp.window.resize()";
    }
  ];

  hardwareBindings = [
    {
      key = "\"XF86AudioMute\"";
      dsp = "hl.dsp.exec_cmd('${ipc} volume muteOutput')";
      opts = "{locked = true}";
    }
    {
      key = "\"switch:Lid Switch\"";
      dsp = "hl.dsp.exec_cmd('${ipc} lockScreen lock')";
      opts = "{locked = true}";
    }
    {
      key = "\"XF86AudioRaiseVolume\"";
      dsp = "hl.dsp.exec_cmd('${ipc} volume increase')";
      opts = "{locked = true; repeating = true}";
    }
    {
      key = "\"XF86AudioLowerVolume\"";
      dsp = "hl.dsp.exec_cmd('${ipc} volume decrease')";
      opts = "{locked = true; repeating = true}";
    }
    {
      key = "\"XF86MonBrightnessUp\"";
      dsp = "hl.dsp.exec_cmd('${ipc} brightness increase')";
      opts = "{locked = true; repeating = true}";
    }
    {
      key = "\"XF86MonBrightnessDown\"";
      dsp = "hl.dsp.exec_cmd('${ipc} brightness decrease')";
      opts = "{locked = true; repeating = true}";
    }
  ];

  # lua helpers
  luaEnvs = lib.concatMapStringsSep "\n" (e: "hl.env(\"${e.name}\", \"${e.value}\")") envs;
  luaBinds = lib.concatMapStringsSep "\n" (b: "hl.bind(\"${b.mod} + ${b.key}\", ${b.dsp})") keyBindings;
  luaMouseBinds = lib.concatMapStringsSep "\n" (m: "hl.bind(\"${m.mod} + ${m.btn}\", ${m.dsp})") mouseBindings;
  luaHardwareBinds = lib.concatMapStringsSep "\n" (h: "hl.bind(${h.key}, ${h.dsp}, ${h.opts})") hardwareBindings;
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {};
    extraConfig = "";
  };

  xdg.configFile."hypr/hyprland.lua".text = ''

    -- env settings
    local ipc = "${ipc}";
    ${luaEnvs}

    -- monitors
    hl.monitor({
      output = "eDP-1",
      mode = "preferred",
      position = "auto",
      scale = 1
    })
    hl.monitor({
      output = "DP-4",
      mode = "preferred",
      position = "auto",
      scale = 1
    })

    -- core
    hl.config({
      autogenerated = false,
      xwayland = {
        enabled = true
      },
      general = {
        gaps_in = ${toString gaps-in},
        gaps_out = ${toString gaps-out},
        border_size = ${toString border-size},
        resize_on_border = true,
        layout = "${layout}",
      },

      decoration = {
        rounding = ${toString rounding},
        rounding_power = ${toString rounding-power},
        active_opacity = ${toString active-opacity},
        inactive_opacity = ${toString inactive-opacity},
        blur = {
          enabled = ${
      if blur
      then "true"
      else "false"
    },
          size = 3,
          passes = 2,
          vibrancy = 0.1696
        },
        shadow = {
          enabled = true,
          range = 4,
          render_power = 3
        },
      },

      animations = {
        enabled = true,
        bezier = { "myBezier, 0.05, 0.9, 0.1, 1.05"},
        animation = {
          "windows, 1, 7, myBezier",
          "windowsOut, 1, 7, default, popin 80%",
          "border, 1, 10, default",
          "borderangle, 1, 8, default",
          "fade, 1, 7, default",
          "workspaces, 1, 6, default"
        }
      },

      dwindle = {
        preserve_split = true
      },

      master = {
        new_status = "master",
        allow_small_split = true,
        mfact = 0.5
      },

      debug = {
        vfr = true
      },

      misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true
      },

      input = {
        kb_layout = "us",
        kb_variant = "intl",
        follow_mouse = true,
        sensitivity = 0.5,
        repeat_delay = 300,
        repeat_rate = 50,
        touchpad = {
          natural_scroll = true
        }
      },

      cursor = {
        no_hardware_cursors = true
      }
    })

    -- auto start processes
    hl.on("hyprland.start", function()
      hl.exec_cmd("${pkgs.noctalia-shell}/bin/noctalia-shell")
      hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
      hl.exec_cmd("systemctl --user stop pipewire pipewire-pulse wireplumber && systemctl --user start pipewire pipewire-pulse wireplumber")
    end)

    -- bindings
    ${luaBinds}
    ${luaMouseBinds}
    ${luaHardwareBinds}

    -- workspaces
    for i = 1, 9 do
      local code = 9 + i
      hl.bind("SUPER + code:" .. code, hl.dsp.focus({ workspace = i}))
      hl.bind("SUPER + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = i}))
    end
  '';
}
