{config, lib, pkgs, nixgl, ...} : {
  nixGL.packages = import nixgl { inherit pkgs; };
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = ["mesa"];
  home.packages = with pkgs; [
    nixgl.nixGLMesa
  ];
}
