{
  inputs,
  vars,
  ...
}: {
  imports = [
    ./hyprland
    ./cli
    ./mime.nix
    ./programs/audio-and-video.nix
    ./programs/browsers.nix
    ./programs/dunst.nix
    ./programs/kitty.nix
    ./programs/noctalia
    #     ./programs/waybar
    ./programs/wofi.nix
    ./scripts
    ./stylix.nix

    # TODO Fix this
    # ./programs/design.nix
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

    sessionVariables = {
      EDITOR = vars.editor;
      XDG_DATA_HOME = "/home/${vars.username}/.local/share";
    };
  };
}
