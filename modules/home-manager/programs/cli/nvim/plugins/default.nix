{pkgs, ...}: {
  imports = [
    ./lualine.nix
    ./telescope.nix
    ./web-devicons.nix
  ];
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
