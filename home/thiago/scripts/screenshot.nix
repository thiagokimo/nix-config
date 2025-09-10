{
  pkgs,
  config,
  ...
}: let
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m output -o ${config.var.picturesDirectory}
  '';
  screenshot-region = pkgs.writeShellScriptBin "screenshot-region" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region -o ${config.var.picturesDirectory}
  '';
in {
  home.packages = [
    screenshot
    screenshot-region
  ];
}
