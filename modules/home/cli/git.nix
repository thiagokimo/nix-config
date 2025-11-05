{configVars, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Thiago Rocha";
      email = "${configVars.email}";
    };
  };
}
