# System services and packages that a graphical session uses.
{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    services = {
      xserver.xkb = {
        layout = "us";
        variant = "intl";
      };
      # Mounting drives and phones from the file manager
      gvfs.enable = true;
      udisks2.enable = true;
      # Battery and power modes, shown by Noctalia
      upower.enable = true;
      power-profiles-daemon.enable = true;
      # Bluetooth applet
      blueman.enable = true;
    };

    environment.systemPackages = with pkgs; [
      xdg-utils
      libmtp
    ];
  };
}
