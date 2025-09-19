{
  config,
  inputs,
  ...
}: {
  imports = [../common/variables-config.nix];
  config.var = {
    hostName = "t14";
    stateVersion = "25.05";
    browser = "google-chrome-stable";
    editor = "nvim";
  };
}
