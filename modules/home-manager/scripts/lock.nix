{pkgs, ...}: let
  menu = pkgs.writeShellScriptBin "lock-hypr" ''
    ${pkgs.hyprlock}/bin/hyprlock
  '';
in {
  home.packages = [
    lock-hypr
  ];
}
