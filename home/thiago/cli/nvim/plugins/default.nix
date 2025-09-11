{pkgs, ...}: {
  imports = [
    ./lualine.nix
  ];
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
