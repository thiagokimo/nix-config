{pkgs, ...}: {
  home.packages = with pkgs; [
    google-chrome # websites
    calibre # ebooks
  ];
}
