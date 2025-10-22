{
  imports = [
    ../common
    ./hardware-configuration.nix

    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/environment.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/services.nix
    ../../modules/nixos/steam.nix

    ../../modules/nixos/desktop/hyprland.nix
  ];

  home-manager.users.${configVars.username} = {
      imports = [
        ./home.nix
      ];
  };
}
