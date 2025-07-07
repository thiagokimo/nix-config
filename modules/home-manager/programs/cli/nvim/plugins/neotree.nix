# modules/plugins/neotree.nix
{
  programs.nixvim = {
    # Set up the Neo-tree plugin
    plugins = {
      neotree = {
        enable = true;
        event = "VeryLazy"; # Translates directly from Lua event
        branch = "v3.x"; # Translates directly from Lua branch

        # Dependencies are defined within the 'plugins' attribute set.
        # These are the standard Nixvim names for these plugins.
        # If 'image.nvim' is optional, you might remove it if you don't use it.
        # I'll include it based on your Lua.
        dependencies = [
          "plenary" # from "nvim-lua/plenary.nvim"
          "nvim-web-devicons" # from "nvim-tree/nvim-web-devicons"
          "nui-nvim" # from "MunifTanjim/nui.nvim"
          "image-nvim" # from "3rd/image.nvim"
        ];

        # The 'config' function in Lua.
        # This will contain the 'require("neo-tree").setup' call as 'settings',
        # and the `vim.fn.sign_define` calls and the `vim.cmd` keymap will go into 'extraConfigLua'.

        # =====================================================================
        # Neo-tree specific settings (from `require('neo-tree').setup { ... }`)
        # =====================================================================
        settings = {
          close_if_last_window = false;
          popup_border_style = "rounded";
          enable_git_status = true;
          enable_diagnostics = true;
          open_files_do_not_replace_types = [ "terminal" "trouble" "qf" ];
          sort_case_insensitive = false;
          sort_function = null; # Lua `nil` is Nix `null`
          # sort_function = '' # Uncomment and provide Lua string if you use a custom function
          #   function (a,b)
          #       if a.type == b.type then
          #           return a.path > b.path
          #       else
          #           return a.type > b.type
          #       end
          #   end
          # '';
          default_component_configs = {
            container = {
              enable_character_fade = true;
            };
            indent = {
              indent_size = 2;
              padding = 1;
              with_markers = true;
              indent_marker = "│";
              last_indent_marker = "└";
              highlight = "NeoTreeIndentMarker";
              with_expanders = null; # Lua `nil` is Nix `null`
              expander_collapsed = "";
              expander_expanded = "";
              expander_highlight = "NeoTreeExpander";
            };
            icon = {
              folder_closed = "";
              folder_open = "";
              folder_empty = "󰜌";
              default = "*";
              highlight = "NeoTreeFileIcon";
            };
            modified = {
              symbol = "[+]";
              highlight = "NeoTreeModified";
            };
            name = {
              trailing_slash = false;
              use_git_status_colors = true;
              highlight = "NeoTreeFileName";
            };
            git_status = {
              symbols = {
                added = "";
                modified = "";
                deleted = "✖";
                renamed = "󰁕";
                untracked = "";
                ignored = "";
                unstaged = "󰄱";
                staged = "";
                conflict = "";
              };
            };
            file_size = {
              enabled = true;
              required_width = 64;
            };
            type = {
              enabled = true;
              required_width = 122;
            };
            last_modified = {
              enabled = true;
              required_width = 88;
            };
            created = {
              enabled = true;
              required_width = 110;
            };
            symlink_target = {
              enabled = false;
            };
          };

          commands = {}; # Empty table remains empty attribute set

          window = {
            position = "left";
            width = 40;
            mapping_options = {
              noremap = true;
              nowait = true;
            };
            mappings = {
              "<space>" = [
                "toggle_node"
                { nowait = false; }
              ];
              "<2-LeftMouse>" = "open";
              "<cr>" = "open";
              "<esc>" = "cancel";
              "P" = [ "toggle_preview" { config = { use_float = true; }; } ]; # Nested config as attribute set
              "l" = "open"; # Changed from 'focus_preview' based on your provided Lua
              "S" = "open_split";
              "s" = "open_vsplit";
              "t" = "open_tabnew";
              "w" = "open_with_window_picker";
              "C" = "close_node";
              "z" = "close_all_nodes";
              "a" = [
                "add"
                { config = { show_path = "none"; }; }
              ];
              "A" = "add_directory";
              "d" = "delete";
              "r" = "rename";
              "y" = "copy_to_clipboard";
              "x" = "cut_to_clipboard";
              "p" = "paste_from_clipboard";
              "c" = "copy";
              "m" = "move";
              "q" = "close_window";
              "R" = "refresh";
              "?" = "show_help"; # Lua uses '?', Nix needs a string
              "<" = "prev_source";
              ">" = "next_source";
              "i" = "show_file_details";
            };
          };

          nesting_rules = {};

          filesystem = {
            filtered_items = {
              visible = false;
              hide_dotfiles = false;
              hide_gitignored = false;
              hide_hidden = false;
              hide_by_name = [
                ".DS_Store"
                "thumbs.db"
                "node_modules"
                "__pycache__"
                ".virtual_documents"
                ".git"
                ".python-version"
                ".venv"
              ];
              hide_by_pattern = [
                # "*.meta" # Uncomment to hide
                # "*/src/*/tsconfig.json" # Uncomment to hide
              ];
              always_show = [
                # ".gitignored" # Uncomment to show
              ];
              never_show = [
                # ".DS_Store" # Uncomment to hide
                # "thumbs.db" # Uncomment to hide
              ];
              never_show_by_pattern = [
                # ".null-ls_*" # Uncomment to hide
              ];
            };
            follow_current_file = {
              enabled = false;
              leave_dirs_open = false;
            };
            group_empty_dirs = false;
            hijack_netrw_behavior = "open_default";
            use_libuv_file_watcher = false;
            window = {
              mappings = {
                "<bs>" = "navigate_up";
                "." = "set_root";
                "H" = "toggle_hidden";
                "/" = "fuzzy_finder";
                "D" = "fuzzy_finder_directory";
                "#" = "fuzzy_sorter";
                "f" = "filter_on_submit";
                "<c-x>" = "clear_filter";
                "[g" = "prev_git_modified";
                "]g" = "next_git_modified";
                "o" = [ "show_help" { nowait = false; config = { title = "Order by"; prefix_key = "o"; }; } ];
                "oc" = [ "order_by_created" { nowait = false; } ];
                "od" = [ "order_by_diagnostics" { nowait = false; } ];
                "og" = [ "order_by_git_status" { nowait = false; } ];
                "om" = [ "order_by_modified" { nowait = false; } ];
                "on" = [ "order_by_name" { nowait = false; } ];
                "os" = [ "order_by_size" { nowait = false; } ];
                "ot" = [ "order_by_type" { nowait = false; } ];
              };
              fuzzy_finder_mappings = {
                "<down>" = "move_cursor_down";
                "<C-n>" = "move_cursor_down";
                "<up>" = "move_cursor_up";
                "<C-p>" = "move_cursor_up";
                # Removed <esc>, <S-CR>, <C-CR>, <C-w> as they are not explicitly present in the Lua for this nested mapping.
                # If they are implicitly inherited or have special behavior, keep them as is.
                # Assuming your Lua 'n' is meant to be a mode or a nested table, converting as such.
                n = {
                  j = "move_cursor_down";
                  k = "move_cursor_up";
                  "<S-CR>" = "close_keep_filter";
                  "<C-CR>" = "close_clear_filter";
                  "<esc>" = "close";
                };
              };
            };
            commands = {};
          };

          buffers = {
            follow_current_file = {
              enabled = true;
              leave_dirs_open = false;
            };
            group_empty_dirs = true;
            show_unloaded = true;
            window = {
              mappings = {
                "bd" = "buffer_delete";
                "<bs>" = "navigate_up";
                "." = "set_root";
                "o" = [ "show_help" { nowait = false; config = { title = "Order by"; prefix_key = "o"; }; } ];
                "oc" = [ "order_by_created" { nowait = false; } ];
                "od" = [ "order_by_diagnostics" { nowait = false; } ];
                "om" = [ "order_by_modified" { nowait = false; } ];
                "on" = [ "order_by_name" { nowait = false; } ];
                "os" = [ "order_by_size" { nowait = false; } ];
                "ot" = [ "order_by_type" { nowait = false; } ];
              };
            };
          };

          git_status = {
            window = {
              position = "float";
              mappings = {
                "A" = "git_add_all";
                "gu" = "git_unstage_file";
                "ga" = "git_add_file";
                "gr" = "git_revert_file";
                "gc" = "git_commit";
                "gp" = "git_push";
                "gg" = "git_commit_and_push";
                "o" = [ "show_help" { nowait = false; config = { title = "Order by"; prefix_key = "o"; }; } ];
                "oc" = [ "order_by_created" { nowait = false; } ];
                "od" = [ "order_by_diagnostics" { nowait = false; } ];
                "om" = [ "order_by_modified" { nowait = false; } ];
                "on" = [ "order_by_name" { nowait = false; } ];
                "os" = [ "order_by_size" { nowait = false; } ];
                "ot" = [ "order_by_type" { nowait = false; } ];
              };
            };
          };
        }; # End of neo-tree.setup settings
      }; # End of neotree plugin definition

      # =====================================================================
      # Dependencies and their configurations
      # =====================================================================
      # nvim-window-picker is a dependency with its own config and keymaps
      nvim-window-picker = {
        enable = true;
        version = "2.*";
        settings = {
          filter_rules = {
            include_current_win = false;
            autoselect_one = true;
            bo = {
              filetype = [ "neo-tree" "neo-tree-popup" "notify" ];
              buftype = [ "terminal" "quickfix" ];
            };
          };
        };
      };

      # Other direct dependencies
      plenary.enable = true;
      nvim-web-devicons.enable = true;
      nui-nvim.enable = true;
      image-nvim.enable = true; # Optional, but included as per your Lua
    }; # End of plugins attribute set

    # =====================================================================
    # Global Neovim configurations from the Lua 'config' function
    # that are not part of `neo-tree.setup` or other plugin settings.
    # =====================================================================

    # Diagnostic signs (vim.fn.sign_define)
    # Nixvim has a structured way to define diagnostic signs directly.
    # This is preferable to using `extraConfigLua` for this specific case.
    diagnostics = {
      # This enables the global diagnostic configuration for signs
      enable = true;
      signs = {
        text = {
          error = " ";
          warn = " ";
          info = " ";
          hint = "󰌵";
        };
        # You can define highlights here too if needed, e.g.:
        # highlight = {
        #   error = "DiagnosticSignError";
        #   warn = "DiagnosticSignWarn";
        #   info = "DiagnosticSignInfo";
        #   hint = "DiagnosticSignHint";
        # };
      };
    };

    # Keymaps that are globally defined outside of a specific plugin's `settings`
    # (e.g., the keymaps within the 'nvim-window-picker' dependency's table,
    # and the final `vim.cmd [[nnoremap \ :Neotree reveal<cr>]]`)
    keymaps = [
      # From nvim-window-picker's `keys` table
      {
        mode = "n";
        key = "<leader>w";
        action = ":Neotree toggle float<CR>";
        options = { silent = true; desc = "Float File Explorer"; };
      }
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle position=left<CR>";
        options = { silent = true; desc = "Left File Explorer"; };
      }
      {
        mode = "n";
        key = "<leader>ngs";
        action = ":Neotree float git_status<CR>";
        options = { silent = true; desc = "Neotree Open Git Status Window"; };
      }
      # From the final `vim.cmd`
      {
        mode = "n";
        key = "\\"; # Note: Lua `\\` in `[[nnoremap \ ...]]` is just `\`
        action = ":Neotree reveal<CR>";
        options = { noremap = true; }; # `nnoremap` in Lua implies `noremap = true`
      }
    ];
  };
}