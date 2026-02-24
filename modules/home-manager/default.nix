{ inputs, vars, ...}: {

  imports = [
    ./hyprland
    ./mime.nix
    ./programs/audio-and-video.nix
    ./programs/browsers.nix
    ./programs/dunst.nix
    ./programs/kitty.nix
    ./programs/waybar
    ./wofi.nix
    ./scripts
    ./stylix.nix

    # TODO Fix this
    # ./design.nix
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

  home = {
    username = "${configVars.username}";
    homeDirectory = "/home/${configVars.username}";
    stateVersion = "${configVars.stateVersion}";

    backupFileExtension = "hm-backup";

    programs.home-manager.enable = true;
    
    sessionVariables = {
      EDITOR = vars.editor;
      XDG_DATA_HOME = "/home/${vars.username}/.local/share";
    };
  };
}
