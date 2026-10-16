# Time zone, keyboard and locale, and the NixOS state version.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.core = {
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
  };
}
