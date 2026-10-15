{
  inputs,
  configVars,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    inputs.pixel-pong.nixosModules.ci-runner
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLisSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}
