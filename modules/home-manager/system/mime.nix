{
  xdg.mimeApps = {
    enable = true;

    # TODO add other mime types
    defaultApplications = {
      "text/markdown" = "nvim.desktop";
      "text/plain" = "nvim.desktop";
      "text/html" = "google-chrome-stable.desktop";
      "image/png" = "google-chrome-stable.desktop";
      "image/jpeg" = "google-chrome-stable.desktop";
      "image/gif" = "google-chrome-stable.desktop";
      "x-scheme-handler/http" = "google-chrome-stable.desktop";
      "x-scheme-handler/https" = "google-chrome-stable.desktop";
      "application/pdf" = "google-chrome-stable.desktop";
    };
  };
}
