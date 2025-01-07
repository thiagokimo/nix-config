{pkgs, ...}: let
  menu = pkgs.writeShellScriptBin "menu" ''
    if pgrep wofi; then
      pkill wofi
    else
      wofi --show drun
    fi
  '';
  # TODO add power menu
in {
  home.packages = [
    menu
  ];
}
