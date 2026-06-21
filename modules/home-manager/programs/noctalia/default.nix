{
  pkgs,
  inputs,
  config,
  vars,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  home.packages = [
    pkgs.hyprshot
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      bar = {
        order = ["top" "bottom"];
        bottom = {
          center = ["media" "spacer_16" "audio_visualizer"];
          enabled = true;
          end = ["tray" "spacer_10" "notifications" "spacer_9" "clipboard" "spacer_8" "bluetooth" "spacer_3" "session"];
          font_family = config.stylix.fonts.monospace.name;
          margin_edge = 0;
          margin_ends = 0;
          position = "bottom";
          radius = 0;
          scale = 1.5;
          start = ["ram" "spacer_2" "temp" "spacer_4" "sysmon"];
        };
        top = {
          center = ["active_window"];
          end = ["brightness" "spacer_12" "volume" "spacer_11" "network" "spacer_7" "battery" "spacer_13" "clock"];
          font_family = config.stylix.fonts.monospace.name;
          margin_edge = 0;
          margin_ends = 0;
          radius = 0;
          scale = 1.5;
          start = ["workspaces" "spacer_14" "taskbar"];
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
          "lockscreen-login-box@eDP-1"
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
          "lockscreen-login-box@eDP-1" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 1144.0;
            cy = 1376.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              show_login_button = true;
            };
          };
          lockscreen-widget-0000000000000001 = {
            box_height = 240.0;
            box_width = 512.0;
            cx = 1112.0;
            cy = 376.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "clock";
          };
          lockscreen-widget-0000000000000002 = {
            box_height = 256.0;
            box_width = 400.0;
            cx = 1664.0;
            cy = 752.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "sysmon";
          };
          lockscreen-widget-0000000000000003 = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 1128.0;
            cy = 752.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "fancy_audio_visualizer";
            settings = {
              background = false;
            };
          };
          lockscreen-widget-0000000000000004 = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 558.0;
            cy = 752.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "weather";
          };
        };
      };

      shell = {
        avatar_path = "${vars.path}/Pictures/my-avatar.jpeg";
        font_family = config.stylix.fonts.monospace.name;
        launch_apps_as_systemd_services = true;
        ui_scale = 1.5;
        screenshot = {
          directory = "${vars.path}/Pictures/Screenshots";
        };
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Gruvbox";
        community_palette = "Oxocarbon";
        wallpaper_scheme = "m3-content";
      };

      weather = {
        enabled = true;
        unit = "celsius";
        effects = true;
      };

      widget = {
        audio_visualizer = {
          color_2 = "secondary";
          scale = 1.5;
        };
        spacer_10 = {type = "spacer";};
        spacer_11 = {type = "spacer";};
        spacer_12 = {type = "spacer";};
        spacer_13 = {type = "spacer";};
        spacer_14 = {type = "spacer";};
        spacer_15 = {type = "spacer";};
        spacer_16 = {type = "spacer";};
        spacer_2 = {type = "spacer";};
        spacer_3 = {type = "spacer";};
        spacer_4 = {type = "spacer";};
        spacer_5 = {type = "spacer";};
        spacer_6 = {type = "spacer";};
        spacer_7 = {type = "spacer";};
        spacer_8 = {type = "spacer";};
        spacer_9 = {type = "spacer";};
      };
    };
  };
}
