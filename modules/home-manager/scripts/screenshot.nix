{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.scripts.screenshot;
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m output -o ${config.home.homeDirectory}/Pictures
  '';
  screenshot-region = pkgs.writeShellScriptBin "screenshot-region" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region -o ${config.home.homeDirectory}/Pictures
  '';
in {
  options.custom.scripts.screenshot = {
    enable = lib.mkEnableOption "Hyprshot screenshot scripts";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      screenshot
      screenshot-region
    ];
  };
}
