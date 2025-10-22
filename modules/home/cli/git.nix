{configVars,...}:{
  programs.git = {
    enable = true;
    userName = "Thiago Rocha";
    userEmail = "${configVars.email}";
  };
}
