{pkgs, config}: let
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m output
  '';
  screenshot-region = pkgs.writeShellScriptBin "screenshot-region" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region
  '';
in {
  home.packages = [
    screenshot
    screenshot-region
  ];
}
