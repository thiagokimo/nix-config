{pkgs, ...}: {
  home.packages = with pkgs; [
    less
    neofetch
    ranger
    unzip
    zip
  ];
}
