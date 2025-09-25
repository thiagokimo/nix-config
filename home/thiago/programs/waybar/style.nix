{config,...}: let 
  font = "${config.stylix.fonts.serif.name}";
  background = "#${config.lib.stylix.colors.base01}";
  hard-background = "#${config.lib.stylix.colors.base00}";
  foreground = "#${config.lib.stylix.colors.base06}";
  red = "#${config.lib.stylix.colors.base08}";
  orange = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  aqua = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  purple = "#${config.lib.stylix.colors.base0E}";
  brown = "#${config.lib.stylix.colors.base0F}";
in {
  programs.waybar.style = ''
    * {
      font-family: ${font};
    }
    #waybar {
      box-shadow: 10px 10px 10px 10px #000000;
    }
    window#waybar {
      box-shadow: 10px 10px 10px 10px #000000;
      background-color: ${background};
      color: ${foreground};
      border-top: 3px solid;
      border-bottom: 3px solid;
      border-color: ${hard-background};
    }
    tooltip {
      background: ${background};
      font-size: 10px;
      opacity: 0.9;
      border-radius: 0px;
      border-width: 2px;
      border-style: solid;
      border-color: ${hard-background};
    }
    .modules-right {
      font-size: 9.8px;
      border-top: 3px solid;
      border-right: 3px solid;
      border-bottom: 3px solid;
      border-color: ${hard-background};
    }
    
    .modules-center {
      border-top: 3px solid;
      border-bottom: 3px solid;
      border-color: ${hard-background};
    }
    
    .modules-left {
      background-color: ${background};
      border-top: 3px solid;
      border-left: 3px solid;
      border-bottom: 3px solid;
      border-color: ${hard-background};
    }
  ''; 
}
