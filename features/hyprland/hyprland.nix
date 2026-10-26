# The Hyprland compositor and its Lua config.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.hyprland = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # decoration vars
    border-size = 2;
    gaps-in = 6;
    gaps-out = 14;
    active-opacity = 1;
    inactive-opacity = 0.92;
    rounding = 14;
    rounding-power = 3;
    layout = "dwindle";

    # stylix palette, as bare hex (no #)
    c = config.lib.stylix.colors;
    rgba = color: alpha: "rgba(${color}${alpha})";

    # noctalia's interface
    ipc = "${config.programs.noctalia.package}/bin/noctalia msg";

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
        dsp = "hl.dsp.exec_cmd('${ipc} session lock')";
      }
      {
        mod = "SUPER";
        key = "PRINT";
        dsp = "hl.dsp.exec_cmd('${ipc} screenshot-fullscreen')";
      }
      {
        mod = "SUPER + SHIFT";
        key = "PRINT";
        dsp = "hl.dsp.exec_cmd('${ipc} screenshot-region')";
      }
      {
        mod = "SUPER";
        key = "SPACE";
        dsp = "hl.dsp.exec_cmd('${ipc} panel-toggle launcher')";
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

      # workspace app launchers
      {
        mod = "SUPER + CTRL";
        key = "6";
        dsp = "hl.dsp.exec_cmd('[workspace 6] ${pkgs.google-chrome}/bin/google-chrome-stable')";
      }
      {
        mod = "SUPER + CTRL";
        key = "8";
        dsp = "function() hl.exec_cmd('[workspace 8] ${pkgs.kitty}/bin/kitty -e ${pkgs.btop}/bin/btop'); hl.exec_cmd('[workspace 8] ${pkgs.kitty}/bin/kitty --dir ${config.home.homeDirectory}/.config/nix-config -e nvim .'); end";
      }
      {
        mod = "SUPER + CTRL";
        key = "9";
        dsp = "function() hl.exec_cmd('[workspace 9] ${pkgs.kitty}/bin/kitty --class kew -e ${pkgs.kew}/bin/kew'); hl.exec_cmd('[workspace 9] ${pkgs.pavucontrol}/bin/pavucontrol'); end";
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
        dsp = "hl.dsp.exec_cmd('${ipc} volume-mute')";
        opts = "{locked = true}";
      }
      {
        key = "\"switch:Lid Switch\"";
        dsp = "hl.dsp.exec_cmd('${ipc} session lock')";
        opts = "{locked = true}";
      }
      {
        key = "\"XF86AudioRaiseVolume\"";
        dsp = "hl.dsp.exec_cmd('${ipc} volume-up')";
        opts = "{locked = true; repeating = true}";
      }
      {
        key = "\"XF86AudioLowerVolume\"";
        dsp = "hl.dsp.exec_cmd('${ipc} volume-down')";
        opts = "{locked = true; repeating = true}";
      }
      {
        key = "\"XF86MonBrightnessUp\"";
        dsp = "hl.dsp.exec_cmd('${ipc} brightness-up')";
        opts = "{locked = true; repeating = true}";
      }
      {
        key = "\"XF86MonBrightnessDown\"";
        dsp = "hl.dsp.exec_cmd('${ipc} brightness-down')";
        opts = "{locked = true; repeating = true}";
      }
    ];

    # lua helpers
    luaEnvs = lib.concatMapStringsSep "\n" (e: "hl.env(\"${e.name}\", \"${e.value}\")") envs;
    luaBinds = lib.concatMapStringsSep "\n" (b: "hl.bind(\"${b.mod} + ${b.key}\", ${b.dsp})") keyBindings;
    luaMouseBinds = lib.concatMapStringsSep "\n" (m: "hl.bind(\"${m.mod} + ${m.btn}\", ${m.dsp})") mouseBindings;
    luaHardwareBinds = lib.concatMapStringsSep "\n" (h: "hl.bind(${h.key}, ${h.dsp}, ${h.opts})") hardwareBindings;

    # SSH windows are titled "<icon> <host> · …" (see zsh.nix); their border
    # takes that host's accent instead of the rotating gradient.
    luaSshRules = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: host: let
      accent = c.${host.accent};
    in "hl.window_rule({ name = \"ssh-${name}\", match = { title = \"^${host.icon} ${name} · .*\" }, border_color = \"${rgba accent "ff"} ${rgba accent "66"}\" })")
    vars.hosts);
  in {
    # noctalia draws the stylix wallpaper itself, so hyprpaper is redundant
    stylix.targets.hyprland.hyprpaper.enable = false;

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
          col = {
            active_border = {
              colors = {"${rgba c.base09 "ff"}", "${rgba c.base0A "ff"}", "${rgba c.base0C "ff"}"},
              angle = 45
            },
            inactive_border = "${rgba c.base01 "cc"}",
          },
        },

        decoration = {
          rounding = ${toString rounding},
          rounding_power = ${toString rounding-power},
          active_opacity = ${toString active-opacity},
          inactive_opacity = ${toString inactive-opacity},
          blur = {
            enabled = true,
            size = 6,
            passes = 3,
            noise = 0.02,
            contrast = 1.05,
            brightness = 0.9,
            vibrancy = 0.2,
            popups = true
          },
          shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            color = "${rgba c.base00 "ee"}",
            color_inactive = "${rgba c.base00 "88"}"
          },
          -- faint orange halo around the focused window only
          glow = {
            enabled = true,
            range = 10,
            render_power = 3,
            color = "${rgba c.base09 "40"}",
            color_inactive = "${rgba c.base00 "00"}"
          },
        },

        animations = {
          enabled = true
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
        hl.exec_cmd("${config.programs.noctalia.package}/bin/noctalia")
        hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
      end)

      -- animations
      hl.curve("snappy",  { type = "spring", mass = 1, stiffness = 260, dampening = 24 })
      hl.curve("easeOut", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
      hl.curve("linear",  { type = "bezier", points = { {0, 0}, {1, 1} } })

      hl.animation({ leaf = "global",           enabled = true, speed = 10,  bezier = "default" })
      hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4,   spring = "snappy",  style = "popin 80%" })
      hl.animation({ leaf = "windowsMove",      enabled = true, speed = 4,   spring = "snappy" })
      hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2,   bezier = "easeOut", style = "popin 85%" })
      hl.animation({ leaf = "fade",             enabled = true, speed = 3,   bezier = "easeOut" })
      hl.animation({ leaf = "border",           enabled = true, speed = 5,   bezier = "easeOut" })
      hl.animation({ leaf = "borderangle",      enabled = true, speed = 100, bezier = "linear",  style = "loop" })
      hl.animation({ leaf = "layersIn",         enabled = true, speed = 3.5, bezier = "easeOut", style = "slide" })
      hl.animation({ leaf = "layersOut",        enabled = true, speed = 2,   bezier = "easeOut", style = "slide" })
      hl.animation({ leaf = "workspaces",       enabled = true, speed = 4,   spring = "snappy",  style = "slidefade 20%" })
      hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,   spring = "snappy",  style = "slidefadevert 20%" })

      -- smart gaps: a lone tiled window fills the screen without border or rounding
      hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
      hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
      hl.window_rule({
        name = "no-gaps-wtv1",
        match = { float = false, workspace = "w[tv1]" },
        border_size = 0,
        rounding = 0,
      })
      hl.window_rule({
        name = "no-gaps-f1",
        match = { float = false, workspace = "f[1]" },
        border_size = 0,
        rounding = 0,
      })

      -- frosted noctalia bars and panels
      hl.layer_rule({
        name = "blur-noctalia",
        match = { namespace = "^noctalia-(bar|panel|attached-panel|notification|osd|overview-launcher|window-switcher|dock).*" },
        blur = true,
        ignore_alpha = 0.2,
      })

      -- window rules
      hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
      hl.window_rule({ name = "steam-workspace", match = { class = "^([Ss]team)$" }, workspace = "7" })
      hl.window_rule({ name = "music-workspace", match = { class = "^(kew|pavucontrol|org.pulseaudio.pavucontrol)$" }, workspace = "9" })
      ${luaSshRules}
      hl.window_rule({
        name = "float-utilities",
        match = { class = "^(blueman-manager|.blueman-manager-wrapped|nm-connection-editor|xdg-desktop-portal-gtk)$" },
        float = true,
        center = true,
        size = "monitor_w*0.45 monitor_h*0.55",
      })
      hl.window_rule({
        name = "float-dialogs",
        match = { title = "^(Open File|Open Folder|Save As|Save File|File Upload|Select a File).*" },
        float = true,
        center = true,
        size = "monitor_w*0.5 monitor_h*0.6",
      })

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
  };
}
