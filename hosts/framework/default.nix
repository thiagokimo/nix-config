{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./i18n.nix
    ./networking.nix
    ./services.nix
    ./system.nix
    ./users.nix
  ];
}
