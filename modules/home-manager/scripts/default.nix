{
  pkgs,
  ...
}: let
  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./sources/ascii.sh);
  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./sources/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./sources/extract.sh);
in {
  home.packages = with pkgs; [
    ascii
    compress
    extract
  ];  
}
