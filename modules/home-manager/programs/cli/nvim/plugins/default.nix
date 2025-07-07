{pkgs, ...}: {
  imports = [
    ./neotree.nix
    ./bufferline.nix
    ./lualine.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
