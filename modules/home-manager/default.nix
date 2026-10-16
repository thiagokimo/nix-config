{vars, ...}: {
  imports = [
    ../base/nixpkgs.nix
    ./cli
    ./hyprland
    ./programs/ai.nix
    ./programs/audio-and-video.nix
    ./programs/browsers.nix
    ./programs/chat.nix
    ./programs/design.nix
    ./programs/dunst.nix
    ./programs/kitty.nix
    ./programs/noctalia
    ./programs/torrent.nix
    ./programs/waybar
    ./programs/wofi.nix
    ./scripts
    ./stylix
    ./xdg.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = vars.user.name;
    homeDirectory = vars.user.home;
    stateVersion = vars.system.stateVersion;
    pointerCursor.enable = true;

    file."Media/Pictures/my-avatar.jpeg".source = ../../assets/my-avatar.jpeg;

    sessionVariables = vars.sessionVariables;
  };
}
