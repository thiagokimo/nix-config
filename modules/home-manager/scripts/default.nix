{pkgs, ...}: let
  ascii = pkgs.writeScriptBin "s-ascii" (builtins.readFile ./sources/ascii.sh);
  compress = pkgs.writeScriptBin "s-compress" (builtins.readFile ./sources/compress.sh);
  extract = pkgs.writeScriptBin "s-extract" (builtins.readFile ./sources/extract.sh);
  wofi-menu = pkgs.writeScriptBin "s-wofi-menu" (builtins.readFile ./sources/wofi-menu.sh);
in {
  home.packages = with pkgs; [
    ascii
    compress
    extract
    wofi-menu
  ];
}
