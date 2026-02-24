{vars, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Thiago Rocha";
      email = "${vars.email}";
    };
  };
}
