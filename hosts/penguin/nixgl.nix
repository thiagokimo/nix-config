{config, lib, pkgs, ...} : {
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = ["mesa"];
  home.packages = with pkgs; [
    nixgl.nixGLMesa
    # Example (config.lib.nixGL.wrap kitty)
  ];
}
