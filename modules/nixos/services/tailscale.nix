{...}: {
  services.tailscale = {
    enable = true;
  };

  networking.firewall = {
    # Allow traffic across the Tailscale interface
    trustedInterfaces = ["tailscale0"];

    # Required if using Tailscale exit nodes or subnet routing
    checkReversePath = "loose";
  };
}
