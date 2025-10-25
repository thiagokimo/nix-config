{config, ...}: let
  font = "${config.stylix.fonts.serif.name}";
  background = "#${config.lib.stylix.colors.base01}";
  hard-background = "#${config.lib.stylix.colors.base00}";
  soft-background = "#${config.lib.stylix.colors.base07}";
  foreground = "#${config.lib.stylix.colors.base06}";
  red = "#${config.lib.stylix.colors.base08}";
  orange = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  aqua = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  purple = "#${config.lib.stylix.colors.base0E}";
  brown = "#${config.lib.stylix.colors.base0F}";

  side-margin = "4px";
in {
  programs.waybar.style = ''
    * {
      font-family: ${font};
    }
    
    #tray {
      padding-left: 4px;
    }
    
    #network {
      color: ${green};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }
        
    #wireplumber {
      color: ${purple};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }

    #battery {
      color: ${yellow};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }

    #bluetooth {
      color: ${blue};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }
    
    #cpu {
      color: ${brown};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }
    
    #temperature {
      color: ${yellow};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }
    
    #memory {
      color: ${blue};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }
    
    #custom-powermenu {
      color: ${red};
      margin-left: ${side-margin};
      margin-right: ${side-margin};
    }
    #custom-separator {
      color: ${soft-background};
      margin: 0 5px;
    }
  '';
}
