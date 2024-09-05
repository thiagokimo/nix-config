{config, ...}: {
  networking = {
    hostName = config.var.hostname;
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 8080 ];
  };
}
