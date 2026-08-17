{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.scripts.app-launcher;
  app-launcher = pkgs.writeShellScriptBin "app-launcher" ''
    if pgrep wofi; then
      pkill wofi
    else
      wofi --show drun
    fi
  '';
  # TODO add power menu
  # TODO add emoji menu
in {
  options.custom.scripts.app-launcher = {
    enable = lib.mkEnableOption "Wofi app-launcher script";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      app-launcher
    ];
  };
}
