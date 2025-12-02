{
  imports = [
    ./tuigreet.nix
  ];

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
  };
}
