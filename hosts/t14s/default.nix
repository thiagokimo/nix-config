{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  # Without the desktop there is no power-profiles-daemon, and the
  # nixos-hardware laptop profile would turn on TLP instead. Its power saving
  # (USB autosuspend, for one) doesn't suit a machine that is always on.
  services.tlp.enable = false;
}
