{configVars,...}: {
  xdg.mimeApps = {
    enable = true;

    # TODO add other mime types
    defaultApplications = {
      "text/markdown" = "${configVars.editor}.desktop";
      "text/plain" = "${configVars.editor}.desktop";
      "text/html" = "${configVars.browser}.desktop";
      "image/png" = "${configVars.browser}.desktop";
      "image/jpeg" = "${configVars.browser}.desktop";
      "image/gif" = "${configVars.browser}.desktop";
      "x-scheme-handler/http" = "${configVars.browser}.desktop";
      "x-scheme-handler/https" = "${configVars.browser}.desktop";
      "application/pdf" = "${configVars.browser}.desktop";
    };
  };
}
