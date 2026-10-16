# Plugins without Nixvim modules.
{
  flake.modules.homeManager.nvim = {pkgs, ...}: {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        vim-nix
        dart-vim-plugin
      ];
    };
  };
}
