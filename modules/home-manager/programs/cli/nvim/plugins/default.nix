{pkgs, ...}: {
  imports = [
    ./lualine.nix
    ./telescope.nix
    ./devicons.nix
  ];
  programs.nixvim.plugins = with pkgs.vimPlugins; [
    vim-nix
  ];
}
