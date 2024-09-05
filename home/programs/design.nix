{pkgs, ...}: {
  home.packages = with pkgs; [
    aseprite # Pixel art editor
    gimp # Image editor
    inkscape # Vector editor
    krita # Illustration
  ];
}
