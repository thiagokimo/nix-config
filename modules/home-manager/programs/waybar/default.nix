{
  config,
  lib,
  ...
}: let
  cfg = config.custom.programs.waybar;
in {
  imports = [
    ./config.nix
    ./style.nix
  ];

  options.custom.programs.waybar = {
    enable = lib.mkEnableOption "Waybar status bar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar.enable = true;
  };
}
