# Lenovo ThinkPad T14s (Intel): the home server, headless and reached over SSH.
{
  config,
  inputs,
  ...
}: {
  vars.hosts.t14s = {
    system = "x86_64-linux";
    features = config.vars.featureSets.base ++ ["github-runners"];

    nixos = {
      imports = [
        ./_hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s
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
    };
  };
}
