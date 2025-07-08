{
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;
      image.enable = true;

      neo-tree = {
        enable = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle position=left<CR>";
        options = { silent = true; desc = "Left File Explorer"; };
      }
      {
        mode = "n";
        key = "\\"; # Note: Lua `\\` in `[[nnoremap \ ...]]` is just `\`
        action = ":Neotree reveal<CR>";
        options = { noremap = true; }; # `nnoremap` in Lua implies `noremap = true`
      }
    ];
  };
}