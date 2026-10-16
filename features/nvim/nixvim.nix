# Neovim through Nixvim, as the default editor.
{
  flake.modules.homeManager.nvim = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [
      inputs.nixvim.homeModules.nixvim
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
  };
}
