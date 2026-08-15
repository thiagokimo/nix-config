{
  config,
  myLib,
  ...
}: let
  inherit (myLib.colors) hexToRgb;

  # Extract Stylix palette
  c = config.lib.stylix.colors;

  red = hexToRgb c.base08;
  orange = hexToRgb c.base09;
  yellow = hexToRgb c.base0A;
  green = hexToRgb c.base0B;
  aqua = hexToRgb c.base0C;
  blue = hexToRgb c.base0D;
  purple = hexToRgb c.base0E;
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        padding = {
          right = 2;
        };
      };
      display = {
        separator = "  ";
        percent = {
          type = 3;
        };
        bar = {
          char = {
            total = "─";
            elapsed = "━";
          };
          border = {
            left = "[";
            right = "]";
          };
          width = 10;
        };
      };
      modules = [
        "title"
        "separator"

        # System Card (Blue)
        {
          type = "custom";
          format = "╭─ 󰟀 System ───────────────────────────────────╮";
          outputColor = "38;2;${blue}";
        }
        {
          type = "os";
          key = "│   OS        ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "kernel";
          key = "│ 󰌽  Kernel    ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "uptime";
          key = "│ 󰔚  Uptime    ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "packages";
          key = "│ 󰏖  Packages  ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "command";
          keyIcon = "󱄅";
          key = "│ 󱄅  Nix Gen   ";
          keyColor = "38;2;${blue}";
          text = "echo \"Sys #$(readlink /nix/var/nix/profiles/system | sed -E 's/.*-([0-9]+)-link/\\1/'), Home #$(readlink ~/.local/state/nix/profiles/home-manager 2>/dev/null | sed -E 's/.*-([0-9]+)-link/\\1/')\"";
        }
        {
          type = "disk";
          key = "│   OS Age    ";
          keyColor = "38;2;${blue}";
          folders = "/";
          format = "{create-time:10} [{days} days]";
        }
        {
          type = "custom";
          format = "╰──────────────────────────────────────────────╯";
          outputColor = "38;2;${blue}";
        }

        # Hardware Card (Aqua)
        {
          type = "custom";
          format = "╭─  Hardware ─────────────────────────────────╮";
          outputColor = "38;2;${aqua}";
        }
        {
          type = "host";
          key = "│ 󰌢  Host      ";
          keyColor = "38;2;${aqua}";
        }
        {
          type = "cpu";
          key = "│   CPU       ";
          keyColor = "38;2;${aqua}";
          showPeCoreCount = true;
          temp = true;
        }
        {
          type = "gpu";
          key = "│ 󰾲  GPU       ";
          keyColor = "38;2;${aqua}";
        }
        {
          type = "memory";
          key = "│   RAM       ";
          keyColor = "38;2;${aqua}";
        }
        {
          type = "disk";
          key = "│   Disk      ";
          keyColor = "38;2;${aqua}";
          folders = "/";
        }
        {
          type = "battery";
          key = "│   Battery   ";
          keyColor = "38;2;${aqua}";
        }
        {
          type = "custom";
          format = "╰──────────────────────────────────────────────╯";
          outputColor = "38;2;${aqua}";
        }

        # Desktop & Network Card (Green)
        {
          type = "custom";
          format = "╭─ 󰍹 Desktop & Network ────────────────────────╮";
          outputColor = "38;2;${green}";
        }
        {
          type = "wm";
          key = "│   WM        ";
          keyColor = "38;2;${green}";
        }
        {
          type = "display";
          key = "│ 󰍹  Display   ";
          keyColor = "38;2;${green}";
          compactType = "original-with-refresh-rate";
        }
        {
          type = "gpu";
          key = "│ 󰾲  G-Driver  ";
          keyColor = "38;2;${green}";
          format = "{driver}";
        }
        {
          type = "localip";
          key = "│ 󰖩  Network   ";
          keyColor = "38;2;${green}";
          showIpv4 = true;
          showIpv6 = false;
          showLoop = false;
        }
        {
          type = "terminal";
          key = "│   Terminal  ";
          keyColor = "38;2;${green}";
        }
        {
          type = "shell";
          key = "│   Shell     ";
          keyColor = "38;2;${green}";
        }
        {
          type = "custom";
          format = "╰──────────────────────────────────────────────╯";
          outputColor = "38;2;${green}";
        }

        # Development Card (Orange)
        {
          type = "custom";
          format = "╭─ 󰅩 Development ──────────────────────────────╮";
          outputColor = "38;2;${orange}";
        }
        {
          type = "editor";
          key = "│ 󱞎  Editor    ";
          keyColor = "38;2;${orange}";
        }
        {
          type = "command";
          keyIcon = "󰊢";
          key = "│ 󰊢  Git       ";
          keyColor = "38;2;${orange}";
          text = "git version";
          format = "git {~12}";
        }
        {
          type = "terminalfont";
          key = "│   Term Font ";
          keyColor = "38;2;${orange}";
        }
        {
          type = "font";
          key = "│   UI Font   ";
          keyColor = "38;2;${orange}";
        }
        {
          type = "custom";
          format = "╰──────────────────────────────────────────────╯";
          outputColor = "38;2;${orange}";
        }

        "break"
        {
          type = "colors";
          symbol = "circle";
        }
      ];
    };
  };
}
