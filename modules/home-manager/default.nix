{vars, ...}: {
  imports = [
    ../base/nixpkgs.nix
    ./cli
    ./programs/ai.nix
    ./scripts
    ./stylix
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
