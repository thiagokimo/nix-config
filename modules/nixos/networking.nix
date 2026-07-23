{hostname, ...}: {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      2234 # soulseek port
    ];
    firewall.allowedUDPPorts = [
      2234 # soulseek port
    ];
  };
}
