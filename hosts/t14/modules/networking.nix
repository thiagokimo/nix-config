{config, ...}: {
  networking = {
    hostName = config.var.hostName;
    networkmanager.enable = true;
  };
}
