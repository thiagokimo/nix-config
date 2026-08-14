{
  config,
  myLib,
  ...
}: let
  inherit (myLib.colors) hexToRgb ansi reset;

  # Extract Stylix palette
  c = config.lib.stylix.colors;

  red = hexToRgb c.base08;
  orange = hexToRgb c.base09;
  yellow = hexToRgb c.base0A;
  green = hexToRgb c.base0B;
  aqua = hexToRgb c.base0C;
  blue = hexToRgb c.base0D;
  purple = hexToRgb c.base0E;
  foreground = hexToRgb c.base05;
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          right = 2;
        };
      };
      display = {
        separator = "  ";
      };
      modules = [
        "title"
        "separator"
        {
          type = "custom";
          format = "${ansi blue}╭─ 󰟀 System ───────────────────────────────────╮${reset}";
        }
        {
          type = "os";
          key = "│  OS        ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "kernel";
          key = "│ 󰌽 Kernel    ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "uptime";
          key = "│ 󰔚 Uptime    ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "packages";
          key = "│ 󰏖 Packages  ";
          keyColor = "38;2;${blue}";
        }
        {
          type = "custom";
          format = "${ansi blue}╰──────────────────────────────────────────────╯${reset}";
        }
        {
          type = "custom";
          format = "${ansi purple}╭─ 󰍹 Desktop ──────────────────────────────────╮${reset}";
        }
        {
          type = "wm";
          key = "│ 󰨇 WM        ";
          keyColor = "38;2;${purple}";
        }
        {
          type = "terminal";
          key = "│ 󰞍 Terminal  ";
          keyColor = "38;2;${purple}";
        }
        {
          type = "shell";
          key = "│ 󰞷 Shell     ";
          keyColor = "38;2;${purple}";
        }
        {
          type = "display";
          key = "│ 󰍹 Display   ";
          keyColor = "38;2;${purple}";
        }
        {
          type = "custom";
          format = "${ansi purple}╰──────────────────────────────────────────────╯${reset}";
        }
        {
          type = "custom";
          format = "${ansi green}╭─  Hardware ─────────────────────────────────╮${reset}";
        }
        {
          type = "host";
          key = "│ 󰌢 Host      ";
          keyColor = "38;2;${green}";
        }
        {
          type = "cpu";
          key = "│ 󰻠 CPU       ";
          keyColor = "38;2;${green}";
          temp = true;
        }
        {
          type = "gpu";
          key = "│ 󰢮 GPU       ";
          keyColor = "38;2;${green}";
        }
        {
          type = "memory";
          key = "│ 󰍛 Memory    ";
          keyColor = "38;2;${green}";
        }
        {
          type = "battery";
          key = "│ 󰁹 Battery   ";
          keyColor = "38;2;${green}";
        }
        {
          type = "custom";
          format = "${ansi green}╰──────────────────────────────────────────────╯${reset}";
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
