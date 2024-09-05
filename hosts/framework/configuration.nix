{config, inputs, ...}: {
  imports = [
    ../modules/boot.nix
    ../modules/fonts.nix
    ../modules/keyboard.nix
    ../modules/networking.nix
    ../modules/nix.nix
    ../modules/sound.nix
    ../modules/timezone.nix
    ../modules/tuigreet.nix
    ../modules/users.nix
    ../modules/utils.nix
    ../modules/zsh.nix

    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = config.var.stateVersion;
}
