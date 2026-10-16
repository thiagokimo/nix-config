{vars, ...}: {
  imports = [
    ../../modules/base
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/environment.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/services
  ];

  system.stateVersion = vars.system.stateVersion;
  time.timeZone = "America/Sao_Paulo";
  console.keyMap = "us-acentos";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };
}
