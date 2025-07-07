# modules/plugins/treesitter.nix
{ pkgs, ... }:

{
  programs.nixvim = {
    # Define the nvim-treesitter plugin
    plugins = {
      treesitter = {
        enable = true; # Enable the nvim-treesitter plugin

        # The 'build' command translates directly
        build = ":TSUpdate";

        # Dependencies for nvim-treesitter.
        # Ensure nvim-treesitter-textobjects is also enabled separately below.
        dependencies = [ "nvim-treesitter-textobjects" ];

        # The 'config' function content, specifically the `require('nvim-treesitter.configs').setup` block,
        # translates to the 'settings' attribute.
        settings = {
          # Languages to be installed for treesitter
          ensure_installed = [
            "lua"
            "python"
            "javascript"
            "typescript"
            "vimdoc"
            "vim"
            "regex"
            "sql"
            "dockerfile"
            "toml"
            "json"
            "java"
            "groovy"
            "go"
            "gitignore"
            "yaml"
            "make"
            "cmake"
            "markdown"
            "markdown_inline"
            "bash"
            "tsx"
            "css"
            "html"
            "kotlin"
          ];

          # Autoinstall languages that are not installed
          auto_install = true;

          highlight = { enable = true; };
          indent = { enable = true; };

          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<c-space>";
              node_incremental = "<c-space>";
              scope_incremental = "<c-s>";
              node_decremental = "<M-space>";
            };
          };

          textobjects = {
            select = {
              enable = true;
              lookahead = true;
              keymaps = {
                aa = "@parameter.outer";
                ia = "@parameter.inner";
                af = "@function.outer";
                iff = "@function.inner"; # Corrected: The Lua was 'if', but 'if' is a reserved word for keymap, using 'iff'
                ac = "@class.outer";
                ic = "@class.inner";
              };
            };
            move = {
              enable = true;
              set_jumps = true;
              goto_next_start = {
                "]m" = "@function.outer";
                "]]" = "@class.outer";
              };
              goto_next_end = {
                "]M" = "@function.outer";
                "][" = "@class.outer";
              };
              goto_previous_start = {
                "[m" = "@function.outer";
                "[[" = "@class.outer";
              };
              goto_previous_end = {
                "[M" = "@function.outer";
                "[]" = "@class.outer";
              };
            };
            swap = {
              enable = true;
              swap_next = {
                "<leader>a" = "@parameter.inner";
              };
              swap_previous = {
                "<leader>A" = "@parameter.inner";
              };
            };
          };
        };
      };

      # Ensure nvim-treesitter-textobjects is enabled as it's a dependency
      nvim-treesitter-textobjects.enable = true;
    };

    # Custom filetype associations from the Lua file need to go into extraConfigLua
    # extraConfigLua = ''
    #   vim.filetype.add { extension = { tf = 'terraform' } }
    #   vim.filetype.add { extension = { tfvars = 'terraform' } }
    #   vim.filetype.add { extension = { pipeline = 'groovy' } }
    #   vim.filetype.add { extension = { multibranch = 'groovy' } }
    # '';
  };
}