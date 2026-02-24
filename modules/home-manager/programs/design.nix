{pkgs, ...}: {
  home.packages = with pkgs; [
    aseprite
    gimp
    inkscape
    krita
  ];
}
