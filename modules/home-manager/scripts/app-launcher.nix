{pkgs, ...}: let
  app-launhcer = pkgs.writeShellScriptBin "app-launcher" ''
    if pgrep wofi; then
      pkill wofi
    else
      wofi --show drun
    fi
  '';
  # TODO add power menu
  # TODO add emoji menu
in {
  home.packages = [
    app-launcher
  ];
}
