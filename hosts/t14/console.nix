{pkgs, ...}: {
  console = {
    packages = with pkgs; [
      jetbrains-mono
    ];
    font = "${pkgs.jetbrains-mono}";
    keyMap = "us-acentos";
  };
}
