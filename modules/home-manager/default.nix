{
  inputs,
  vars,
  ...
}: {
  imports = [
    ./cli
    ./hyprland
    ./programs/audio-and-video.nix
    ./programs/browsers.nix
    ./programs/kitty.nix
    ./programs/noctalia
    ./programs/torrent.nix
    ./scripts
    ./stylix.nix
    ./xdg.nix

    # TODO Fix this
    ./programs/design.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = with inputs.self.overlays; [
      additions
      modifications
      stable-packages
    ];
  };

  programs.home-manager.enable = true;

  home = {
    username = "${vars.username}";
    homeDirectory = "/home/${vars.username}";
    stateVersion = "${vars.stateVersion}";

    file."Pictures/my-avatar.jpeg".source = ./assets/my-avatar.jpeg;

    sessionVariables = {
      EDITOR = vars.editor;
      XDG_DATA_HOME = "/home/${vars.username}/.local/share";
    };
  };
}
