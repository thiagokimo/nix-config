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
      font-family: "${font}";
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

    #workspaces {
      background-color: ${background};
      color: ${foreground};
      padding-left: 1em;
      font-size: 9.9px;
    }
    #workspaces button {
      color: ${foreground};
      padding: 0 6px;
      font-size: 9.9px;
    }
    #workspaces button:hover {
      background-color: ${aqua};
      color: #000000;
    }
    #workspaces button.visible.active {
      color: ${red};
      font-size: 12.5px;
    }
    #workspaces button.visible {
      color: ${aqua};
    }
    #workspaces button.active:hover {
      background-color: ${aqua};
      color: #000000;
      font-size: 12px;
    }
    
    #clock {
      font-size: 10px;
      background-color: ${background};
      padding-right: 1em;
      padding-top: 3px;
      padding-left: 1em;
      border-right: 3px;
      border-right-style: solid;
      border-right-color: ${yellow};
    }

    #battery {
      color: ${foreground};
      padding-left: 0.5em;
      padding-right: 1.5em;
    }
    #battery.charging,
    #battery.plugged {
      color: ${foreground};
    }
    
    #memory {
      padding-left: 1em;
      padding-right: 1em;
    }
    
    #cpu {
      padding-right: 1em;
      padding-left: 1.5em;
      border-left: 3px;
      border-left-style: solid;
      border-left-color: ${green};
    }
    
    #network {
      padding-right: 2em;
      padding-left: 1em;
    }
    
    #wireplumber {
      background-color: ${background};
      padding-right: 1em;
      padding-left: 1.5em;
    }
  ''; 
}
