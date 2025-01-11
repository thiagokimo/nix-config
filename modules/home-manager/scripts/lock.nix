{pkgs, ...}: let
  lock-hypr = pkgs.writeShellScriptBin "lock-hypr" ''
    ${pkgs.hyprlock}/bin/hyprlock
  '';
in {
  home.packages = [
    pkgs.hyprlock 
    lock-hypr
  ];
}
