{pkgs, ...}: {
  imports = [
    ./lualine.nix
    ./neotree.nix
  ];
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
