{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./plugins
    ./options.nix
    ./keymaps.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    nixpkgs.source = inputs.nixpkgs;

    extraPackages = with pkgs; [
      nerd-fonts.jetbrains-mono
      stylua
    ];

    colorschemes.gruvbox.enable = true;
  };
}
