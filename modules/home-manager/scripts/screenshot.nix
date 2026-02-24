{
  pkgs,
  config,
  ...
}: let
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m output -o ${config.home.homeDirectory}/Pictures
  '';
  screenshot-region = pkgs.writeShellScriptBin "screenshot-region" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region -o ${config.home.homeDirectory}/Pictures
  '';
in {
  home.packages = [
    screenshot
    screenshot-region
  ];
}
