{inputs, ...} : {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./themes.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
