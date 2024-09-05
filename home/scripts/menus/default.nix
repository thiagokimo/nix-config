{pkgs, ...}: let
  menu = pkgs.writeShellScriptBin "menu" ''
    if pgrep wofi; then
      pkill wofi
    else
      wofi --show drun
    fi
  '';

  lock = pkgs.writeShellScriptBin "lock" ''
    ${pkgs.hyprlock}/bin/hyprlock
  '';
  # TODO add power menu
in {
  home.packages = [
    menu
    lock
  ];
}
