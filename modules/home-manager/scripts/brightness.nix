{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.scripts.brightness;
  increments = "5";

  brightness-change = pkgs.writeShellScriptBin "brightness-change" ''
    [[ $1 == "up" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ''${2-${increments}}%+
    [[ $1 == "down" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ''${2-${increments}}%-
  '';

  brightness-set = pkgs.writeShellScriptBin "brightness-set" ''
    ${pkgs.brightnessctl}/bin/brightnessctl set ''${1-100}%
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    brightness-change up ${increments}
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    brightness-change down ${increments}
  '';
in {
  options.custom.scripts.brightness = {
    enable = lib.mkEnableOption "Brightness control scripts";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.brightnessctl
      brightness-change
      brightness-up
      brightness-down
      brightness-set
    ];
  };
}
