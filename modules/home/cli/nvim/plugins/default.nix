{pkgs, ...}: {
  imports = [
    ./lualine.nix
    # ./neotree.nix
    ./bufferline.nix
  ];
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      dart-vim-plugin
    ];
  };
}
