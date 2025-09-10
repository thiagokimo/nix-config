{config, ...}: {
  imports = [../common/variables-config.nix];
  config.var = {
    hostName = "t14";
    stateVersion = "25.05";
  };
}
