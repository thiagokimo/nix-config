{
  pkgs,
  vars,
  lib,
  ...
}: let
  apps = {
    browser = vars.defaults.browser.desktop;
    editor = vars.defaults.editor.desktop;
    pdf = vars.defaults.pdfViewer.desktop;
    image = vars.defaults.imageViewer.desktop;
    media = vars.defaults.mediaPlayer.desktop;
    fileManager = vars.defaults.fileManager.desktop;
  };

  mimeGroups = {
    ${apps.browser} = [
      "text/html"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
      "x-scheme-handler/chrome"
    ];

    ${apps.editor} = [
      "text/plain"
      "text/markdown"
      "text/x-makefile"
      "text/x-shellscript"
      "application/json"
      "application/x-yaml"
      "application/xml"
    ];

    ${apps.pdf} = [
      "application/pdf"
      "application/x-pdf"
      "application/x-bzpdf"
      "application/x-gzpdf"
    ];

    ${apps.image} = [
      "image/png"
      "image/jpeg"
      "image/gif"
      "image/webp"
      "image/bmp"
      "image/tiff"
      "image/svg+xml"
      "image/*"
    ];

    ${apps.media} = [
      "audio/*"
      "video/*"
      "video/mp4"
      "video/mkv"
      "video/webm"
      "audio/mpeg"
      "audio/flac"
    ];

    ${apps.fileManager} = [
      "inode/directory"
    ];
  };

  defaultApplications = lib.concatMapAttrs (
    desktopApp: mimeList:
      lib.genAttrs mimeList (_mime: [desktopApp])
  ) mimeGroups;
in {
  xdg = {
    portal = {
      enable = true;
      config = {
        common = {default = ["hyprland" "gtk"];};
        hyprland = {default = ["hyprland" "gtk"];};
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    mimeApps = {
      enable = true;
      inherit defaultApplications;
    };
  };
}

