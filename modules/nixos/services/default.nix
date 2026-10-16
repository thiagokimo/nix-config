{
  imports = [
    ./tailscale.nix
  ];

  programs.dconf.enable = true;

  services = {
    fwupd.enable = true;
    openssh = {
      enable = true;
    };
  };
}
