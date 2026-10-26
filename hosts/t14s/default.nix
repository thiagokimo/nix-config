# Lenovo ThinkPad T14s (Intel): the home server, headless and reached over SSH.
{
  config,
  inputs,
  ...
}: {
  vars.hosts.t14s = {
    system = "x86_64-linux";
    features = config.vars.featureSets.base ++ ["github-runners" "ssh-agent"];
    # purple with a server glyph, apart from the laptops' aqua and yellow.
    accent = "base0E";
    icon = "󰒋";
    tailscaleIp = "100.115.181.106";

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

      # Start the user's systemd instance at boot and keep it after logout, so
      # user services such as the SSH agent don't depend on an open SSH session.
      users.users.${config.vars.user.name}.linger = true;

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
