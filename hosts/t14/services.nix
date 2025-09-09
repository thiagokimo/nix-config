{
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "intl";
    };
    fwupd.enable = true;
    openssh = {
      enable = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
