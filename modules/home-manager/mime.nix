{vars, ...}: let
  browser = "${vars.browser}";
  editor = "${vars.editor}";
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/markdown" = "${editor}.desktop";
      "text/plain" = "${editor}.desktop";
      "text/html" = "${browser}.desktop";
      "image/png" = "${browser}.desktop";
      "image/jpeg" = "${browser}.desktop";
      "image/gif" = "${browser}.desktop";
      "x-scheme-handler/http" = "${browser}.desktop";
      "x-scheme-handler/https" = "${browser}.desktop";
      "x-scheme-handler/about" = "${browser}.desktop";
      "x-scheme-handler/unknown" = "${browser}.desktop";
      "application/pdf" = "${browser}.desktop";
    };
  };
}
