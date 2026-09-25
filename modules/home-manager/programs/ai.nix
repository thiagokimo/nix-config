{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.programs.ai;
in {
  options.custom.programs.ai = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable AI development tools and assistants.";
    };

    claude-code = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable Claude Code (Anthropic's terminal agent).";
      };

      package = lib.mkPackageOption pkgs "claude-code" {};
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      example = lib.literalExpression "[ pkgs.ripgrep ]";
      description = "Additional AI packages or complementary tools to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      (lib.optionals cfg.claude-code.enable [
        cfg.claude-code.package
      ])
      ++ cfg.extraPackages;
  };
}
