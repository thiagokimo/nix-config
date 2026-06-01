{
  imports = [
    ./tuigreet.nix
    ./kanata.nix
  ];

  programs.dconf.enable = true;

  services = {
    xserver = {
      # enable = true;
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };
    fwupd.enable = true;
    openssh = {
      enable = true;
    };
    gvfs.enable = true;
    udisks2.enable = true;

    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
}
