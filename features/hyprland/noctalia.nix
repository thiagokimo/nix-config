# Noctalia, the desktop shell for Hyprland: bars, launcher, notifications and
# lock screen.
{
  config,
  inputs,
  ...
}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.hyprland = {
    pkgs,
    config,
    ...
  }: let
    host = vars.hosts.${config.host.name};
    c = config.lib.stylix.colors;
    accent = c.${host.accent};

    # The lock screen widgets are placed from the host's screen size.
    display =
      if host.display != null
      then host.display
      else {
        output = "eDP-1";
        width = 1920;
        height = 1080;
      };

    width = display.width * 1.0;
    height = display.height * 1.0;
    output = display.output;

    centerX = width / 2.0;
    centerY = height / 2.0;
  in {
    home.packages = [
      pkgs.hyprshot
    ];

    programs.noctalia = {
      enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        # One floating top bar. The bar itself is transparent and the widgets
        # sit in capsule groups, so only those "islands" are drawn and blurred.
        bar = {
          order = ["main"];
          main = {
            position = "top";
            scale = 1.5;
            thickness = 30;
            margin_edge = 8;
            margin_ends = 8;
            padding = 0;
            widget_spacing = 6;
            background_opacity = 0.0;
            shadow = false;
            dead_zone.click_through = true;
            font_family = config.stylix.fonts.monospace.name;
            font_weight = 600;

            capsule = true;
            capsule_fill = "surface";
            capsule_opacity = 0.92;
            capsule_border = "#${c.base02}";
            capsule_thickness = 0.9;
            capsule_radius = 8;

            start = ["launcher" "workspaces" "active_window"];
            center = ["group:time"];
            end = ["group:media" "group:sysmon" "group:status" "group:system"];

            capsule_group = [
              {
                id = "time";
                members = ["weather" "clock"];
                widget_spacing = 12;
              }
              {
                id = "media";
                members = ["media" "audio_visualizer"];
              }
              {
                # Only the CPU shows until hovered.
                id = "sysmon";
                members = ["cpu" "ram" "temp"];
                accordion = true;
                accordion_direction = "start";
                accordion_delay_ms = 150;
              }
              {
                id = "status";
                members = ["tray" "network" "bluetooth" "volume" "brightness" "battery"];
                widget_spacing = 12;
              }
              {
                id = "system";
                members = ["notifications" "clipboard" "session"];
              }
            ];
          };
        };

        launcher = {
          terminal_command = "systemd-run --user --scope --collect --";
        };

        location = {
          auto_locate = false;
          address = "Belo Horizonte";
        };

        lockscreen_widgets = {
          enabled = true;
          schema_version = 2;
          widget_order = [
            "lockscreen-login-box@${output}"
            "lockscreen-widget-0000000000000001"
            "lockscreen-widget-0000000000000002"
            "lockscreen-widget-0000000000000003"
            "lockscreen-widget-0000000000000004"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            "lockscreen-login-box@${output}" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = centerX;
              cy = height - 128.0;
              inherit output;
              rotation = 0.0;
              type = "login_box";
              settings = {
                show_login_button = true;
              };
            };
            lockscreen-widget-0000000000000001 = {
              box_height = 240.0;
              box_width = 512.0;
              cx = centerX;
              cy = height * 0.25;
              inherit output;
              rotation = 0.0;
              type = "clock";
            };
            lockscreen-widget-0000000000000002 = {
              box_height = 256.0;
              box_width = 400.0;
              cx = width * 0.75;
              cy = centerY;
              inherit output;
              rotation = 0.0;
              type = "sysmon";
            };
            lockscreen-widget-0000000000000003 = {
              box_height = 0.0;
              box_width = 0.0;
              cx = centerX;
              cy = centerY;
              inherit output;
              rotation = 0.0;
              type = "fancy_audio_visualizer";
              settings = {
                background = false;
              };
            };
            lockscreen-widget-0000000000000004 = {
              box_height = 0.0;
              box_width = 0.0;
              cx = width * 0.25;
              cy = centerY;
              inherit output;
              rotation = 0.0;
              type = "weather";
            };
          };
        };

        shell = {
          avatar_path = "${vars.user.home}/Media/Pictures/my-avatar.jpeg";
          font_family = config.stylix.fonts.monospace.name;
          launch_apps_as_systemd_services = true;
          panel = {
            transparency_mode = "glass";
          };
          ui_scale = 1.5;
          screenshot = {
            directory = "${vars.user.home}/Media/Pictures/Screenshots";
          };
        };

        theme = {
          mode = "dark";
          builtin = "Gruvbox";
          community_palette = "Oxocarbon";
          wallpaper_scheme = "m3-content";
        };

        weather = {
          enabled = true;
          unit = "celsius";
          effects = true;
        };

        # Each status icon gets its own gruvbox hue; the host accent marks the
        # launcher and the focused workspace, as it does in kitty and the prompt.
        widget = {
          launcher = {
            custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
            custom_image_colorize = true;
            color = "#${accent}";
          };
          workspaces = {
            style = "regular";
            show_labels = false;
            pill_scale = 0.5;
            active_pill_size = 2.8;
            capsule_padding = 10;
            focused_color = "#${accent}";
            occupied_color = "#${c.base04}";
            empty_color = "#${c.base03}";
          };
          active_window = {
            capsule = false;
            color = "#${c.base04}";
            font_weight = 500;
            max_length = 360;
          };
          weather = {
            show_condition = false;
            icon_color = "#${c.base0A}";
          };
          clock = {
            format = "{:%a %d %b  %H:%M}";
            font_weight = 800;
            color = "on_surface";
          };
          media = {
            hide_when_no_media = true;
            max_length = 260;
          };
          audio_visualizer = {
            color_2 = "secondary";
          };
          cpu = {
            type = "sysmon";
            stat = "cpu_usage";
            visualization = "none";
            icon_color = "#${c.base0B}";
          };
          ram = {
            type = "sysmon";
            stat = "ram_used";
            visualization = "none";
            icon_color = "#${c.base0D}";
          };
          temp = {
            type = "sysmon";
            stat = "cpu_temp";
            visualization = "none";
            icon_color = "#${c.base0E}";
          };
          network = {
            show_label = false;
            icon_color = "#${accent}";
          };
          bluetooth.icon_color = "#${c.base0D}";
          volume.icon_color = "#${c.base09}";
          brightness = {
            show_label = false;
            icon_color = "#${c.base0A}";
          };
          battery.icon_color = "#${c.base0B}";
          session.color = "error";
        };
      };
    };
  };
}
