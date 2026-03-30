{
  imports = [
    ./tuigreet.nix
    ./kanata.nix
  ];

  programs.dconf.enable = true;

  services = {
    xserver.xkb = {
      layout = "us";
      variant = "intl";
    };
    fwupd.enable = true;
    openssh = {
      enable = true;
    };
    gvfs.enable = true;

    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
}
