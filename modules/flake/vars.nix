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
      display = {
        output = mkOption {
          type = types.str;
          example = "eDP-1";
        };
        width = mkOption {type = types.ints.positive;};
        height = mkOption {type = types.ints.positive;};
      };
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

    hosts = mkOption {
      type = types.attrsOf host;
      default = {};
      description = "Machines built by this flake. Each gets a NixOS and a Home Manager configuration.";
    };
  };
}
