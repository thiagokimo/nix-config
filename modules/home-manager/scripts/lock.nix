{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.scripts.lock;
  lock-hypr = pkgs.writeShellScriptBin "lock-hypr" ''
    ${pkgs.hyprlock}/bin/hyprlock
  '';
in {
  options.custom.scripts.lock = {
    enable = lib.mkEnableOption "Hyprlock screen lock script";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprlock
      lock-hypr
    ];
  };
}
