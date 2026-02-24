{config, ...}: let
  font = "${config.stylix.fonts.serif.name}";
  background = "#${config.lib.stylix.colors.base01}";
  hard-background = "#${config.lib.stylix.colors.base00}";
  soft-background2 = "#${config.lib.stylix.colors.base06}";
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
      padding: 0;
      margin: 0;
      min-height: 0;
      border-radius: 0px;
      border: none;
      text-shadow: none;
      transition: none;
      box-shadow: none;
    }
    window#waybar {
      background: ${hard-background};
      padding: 3px 0;
    }
    
    window#waybar.hidden {
      opacity: 0.98;
    } 
    #window,
    #tray,
    #network,
    #wireplumber,
    #battery,
    #backlight,
    #clock,
    #memory,
    #cpu,
    #custom-launcher,
    #workspaces,
    #mpris {
      font-family: ${font};
      /* font-size: 10.5px; */
      font-weight: 600;
      color: ${hard-background};
      margin-right: 6px;
      margin-left: 6px;
      padding: 3px 7px;
      border-bottom: 2px solid;
      margin-top: 2px;
      margin-bottom: 2px;
    }

    /* --------------- */
    /* workspaces */
    /* --------------- */
    #workspaces {
      padding: 3px 7px;
      border-bottom: 2px solid;
      margin-top: 2px;
      margin-right: 2px;
      margin-left: 2px;
      padding: 0;
    }
    
    #workspaces button {
      color: ${foreground};
      border-radius: 0;
      margin-bottom: 3px;
      margin-top: 3px;
      margin-right: 1px;
      margin-left: 1px;
      min-width: 20px;
      padding: 0 2px;
    }
    
    #workspaces button:hover {
      background: ${orange};
      color: ${hard-background};
    }
    
    #workspaces button.active {
      background: ${green};
      color: ${hard-background};
    }
    
    #workspaces button.urgent {
      background: ${red};
    }

    /* ----------- */
    /* window */
    /* ----------- */

    #window {
      color: ${hard-background};
      background: ${aqua};
      border-radius: 0;
      margin-top: 2px;
      margin-bottom: 2px;
      margin-left: 6px;
      margin-right: 6px;
      padding: 3px 7px;
      border-bottom-color: ${aqua};
    }
    
    window#waybar.empty #window {
      margin: 0;
      padding: 0;
      background: transparent;
      color: transparent;
      border-bottom: none;
    }

    /* ---------- */
    /* network */
    /* ---------- */

    #network {
      color: ${green};
      border-bottom-color: ${green};
    }
    
    #network.disconnected {
      color: ${aqua};
      border-bottom-color: ${aqua};
    }

    /* ---------- */
    /* audio */
    /* ---------- */

    #wireplumber {
      color: ${green};
      border-bottom-color: ${green};
    }
    
    #wireplumber.muted {
      color: ${red};
      border-bottom-color: ${red};
    }

    /* ---------- */
    /* cpu */
    /* ---------- */
    
    #cpu {
      color: ${yellow};
      border-bottom-color: ${yellow};
    }

    /* ---------- */
    /* memory */
    /* ---------- */

    #memory {
      color: ${brown};
      border-bottom-color: ${brown};
    }
    
    /* ---------- */
    /* backlight */
    /* ---------- */
    
    #backlight {
      color: ${orange};
      border-bottom-color: ${orange};
    }

    /* ---------- */
    /* battery */
    /* ---------- */

    #battery {
      color: ${yellow};
      border-bottom-color: ${yellow};
    }
    
    #battery.charging, #battery.plugged {
      color: ${yellow};
      border-bottom-color: ${yellow};
    }
    
    #battery.critical:not(.charging) {
      color: ${red};
      border-bottom-color: ${red};
    }

    /* ---------- */
    /* clock */
    /* ---------- */

    #clock {
      color: ${green};
      border-bottom-color: ${green};
    }

    /* ---------- */
    /* tray */
    /* ---------- */

    #tray {
      padding: 3px 7px;
      margin-left: 6px;
      margin-right: 6px;
      border-bottom-color: ${soft-background};
    }

    /* ---------------- */
    /* custom-launcher */
    /* ---------------- */

    #custom-launcher {
      color: ${blue};
      /* font-size: 12px; */
      margin-left: 6px;
      margin-right: 6px;
      border-bottom-color: ${blue};
    }

    /* ---------------- */
    /* bluetooth */
    /* ---------------- */

    #bluetooth {
      color: ${blue};
      border-bottom-color: ${blue};
    }

    /* ---------------- */
    /* media player */
    /* ---------------- */

    #mpris {
      color: ${green};
      border-bottom-color: ${green};
    }
    
    #mpris:hover {
      color: ${yellow};
      border-bottom-color: ${yellow};
    }
    
    /* ---------------- */
    /* taskbar */
    /* ---------------- */
    
    #taskbar {
      background: transparent;
      padding: 0;
      margin-left: 6px;
      margin-right: 6px;
      border-bottom: none;
    }
    
    #taskbar button {
      background: transparent;
      border: none;
      border-radius: 0;
      margin: 2px 1px;
      padding: 2px 2px;
      color: ${soft-background2};
      border-bottom: 2px solid ${brown};
      min-width: 14px;
    }
    
    #taskbar button.active {
      border-bottom-color: ${yellow};
    }
    
    #taskbar button:hover {
      border-bottom-color: ${orange};
    }
    
    #taskbar button.urgent {
      border-bottom-color: ${red};
    }
  '';
}
