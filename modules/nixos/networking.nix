{configVars, ...}: {
  networking = {
    hostName = configVars.hostName;
    networkmanager.enable = true;
  };
}
