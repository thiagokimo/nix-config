{
  config,
  configVars,
  ...
}: {
  programs.nh = {
    enable = true;

    clean = {
      enable = !config.nix.gc.automatic;
      dates = "weekly";
    };

    flake = "${configVars.path}";
  };
}
