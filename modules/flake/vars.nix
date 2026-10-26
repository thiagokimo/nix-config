# Declares the `vars` flake option: global constants shared by the flake, the
# features and the NixOS and Home Manager modules. The values are set in
# vars.nix at the root.
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.vars;

  app = types.submodule {
    options = {
      bin = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Command that starts the app.";
      };
      desktop = mkOption {
        type = types.str;
        description = "Desktop entry of the app, used for default applications.";
      };
    };
  };

  host = types.submodule {
    options = {
      system = mkOption {
        type = types.str;
        example = "x86_64-linux";
      };
      features = mkOption {
        type = types.listOf types.str;
        description = "Features from features/ that this host gets, in both NixOS and Home Manager.";
      };
      display = mkOption {
        type = types.nullOr display;
        default = null;
        description = "Built-in screen, for hosts with a desktop.";
      };
      accent = mkOption {
        type = types.enum ["base08" "base09" "base0A" "base0B" "base0C" "base0D" "base0E" "base0F"];
        default = "base0D";
        description = "Stylix palette slot that identifies the host in prompts and terminals, so SSH sessions on different machines don't look alike.";
      };
      icon = mkOption {
        type = types.str;
        default = "󰌢";
        description = "Nerd Font glyph shown next to the host name in prompts and window titles.";
      };
      tailscaleIp = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Tailscale address, so SSH sessions opened by IP get the host's terminal colors too.";
      };
      nixos = mkOption {
        type = types.deferredModule;
        default = {};
        description = "The machine's own NixOS configuration, set in hosts/<name>: hardware and anything only this host needs.";
      };
    };
  };

  display = types.submodule {
    options = {
      output = mkOption {
        type = types.str;
        example = "eDP-1";
      };
      width = mkOption {type = types.ints.positive;};
      height = mkOption {type = types.ints.positive;};
    };
  };
in {
  options.vars = {
    user = {
      name = mkOption {type = types.str;};
      email = mkOption {type = types.str;};
      home = mkOption {
        type = types.str;
        default = "/home/${cfg.user.name}";
      };
      configDir = mkOption {
        type = types.str;
        default = "${cfg.user.home}/.config/nix-config";
        description = "Where this repository is checked out.";
      };
    };

    system.stateVersion = mkOption {type = types.str;};

    sessionVariables = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Applied both system-wide (NixOS) and to the user session (Home Manager).";
    };

    defaults = mkOption {
      type = types.attrsOf app;
      default = {};
      description = "Default apps, by role.";
    };

    featureSets = mkOption {
      type = types.attrsOf (types.listOf types.str);
      default = {};
      example = {laptop = ["desktop" "hyprland"];};
      description = "Named lists of features that hosts combine in their features list.";
    };

    hosts = mkOption {
      type = types.attrsOf host;
      default = {};
      description = "Machines built by this flake, each set in hosts/<name>. Each gets a NixOS and a Home Manager configuration.";
    };
  };
}
