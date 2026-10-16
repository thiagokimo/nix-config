# Bluetooth, with bluetui to manage it from the terminal. The desktop feature
# adds the blueman applet.
{
  flake.modules.nixos.bluetooth = {pkgs, ...}: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    environment.systemPackages = [pkgs.bluetui];
  };
}
