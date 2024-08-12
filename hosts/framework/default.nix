{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./i18n.nix
    ./users.nix
    ./services.nix
    ./system.nix
  ];
}
