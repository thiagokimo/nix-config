{
  lib,
  config,
  ...
}: {
  imports = [
    ./base
  ];

  home = {
    username = "thiago";
    persistence."/persist/${config.home.homeDirectory}" = lib.mkForce {};
  };
}
