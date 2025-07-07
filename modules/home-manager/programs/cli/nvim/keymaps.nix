let 
  optionsDefaults = {
    silent = true;
    noremap = true;
  };
in {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = {
      # Disable the spacebar key's default behavior in normal and visual modes
      {
        mode = [ "n" "v" ];
        key = "<Space>";
        action = "<Nop>";
        options = {
          silent = true;
        };
      }
      # Clear highlighted searches when pressing escape
      {
        key = "<esc>";
        action = ":noh<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Clear search";
        };
      }
      # Scroll up and down
      {
        key = "<C-d>";
        action = "<C-d>zz";
        mode = "n";
        options = optionsDefaults // {
          desc = "Scroll down and center"
        };
      }
      {
        key = "<C-u>";
        action = "<C-u>zz";
        mode = "n";
        options = optionsDefaults // {
          desc = "Scroll up and center"
        };
      }
      # Resize windows with arrows
      {
        key = "<Up>";
        action = ":resize -2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Decrease the size of the buffer horizontally"
        };
      }
      {
        key = "<Down>";
        action = ":resize +2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Increase the size of the buffer horizontally"
        };
      }
      {
        key = "<Left>";
        action = ":vertical resize +2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Increase the size of the buffer on the right"
        };
      }
      {
        key = "<Right>";
        action = ":vertical resize -2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Increase the size of the buffer on the left"
        };
      }
      # Buffers
      {
        key = "<Tab>";
        action = ":bnext<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Navigate to the next buffer"
        };
      }
      {
        key = "<S-Tab>";
        action = ":bprevious<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Navigate to the previous buffer"
        };
      }
      {
        key = "<leader>x";
        action = ":Bdelete!<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Close buffer"
        };
      }
      {
        key = "<leader>b";
        action = "<cmd> enew <CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "New buffer"
        };
      }
      # Navigate between splits
      {
        key = "<C-k>";
        action = ":wincmd k<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Move to the split above";
        };
      }
      {
        key = "<C-j>";
        action = ":wincmd j<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Move to the split below";
        };
      }
      {
        key = "<C-h>";
        action = ":wincmd h<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Move to the split on the left";
        };
      }
      {
        key = "<C-l>";
        action = ":wincmd h<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Move to the split on the right";
        };
      }
      # Tabs
      {
        key = "<leader>to";
        action = ":tabnew<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Open new tab";
        };
      }
      {
        key = "<leader>tx";
        action = ":tabclose<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Close current tab";
        };
      }
      {
        key = "<leader>tn";
        action = ":tabn<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Go to next tab";
        };
      }
      {
        key = "<leader>tp";
        action = ":tabp<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Go to previous tab";
        };
      }
      # Toggle line wrapping
      {
        key = "<leader>lw";
        action = "<cmd>set wrap!<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Toggle line wrapping";
        };
      }
      # Stay in indent mode
      {
        key = "<";
        action = "<gv";
        mode = "v";
        options = optionsDefaults // {
          desc = "Stay in indent mode when pressing <";
        };
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
        options = optionsDefaults // {
          desc = "Stay in indent mode when pressing >";
        };
      }
      # Move text
      {
        key = "<A-j>";
        action = ":m .+1<CR>==";
        mode = "v";
        options = optionsDefaults // {
          desc = "Move text 1 line down";
        };
      }
      {
        key = "<A-k>";
        action = ":m .-1<CR>==";
        mode = "v";
        options = optionsDefaults // {
          desc = "Move text 1 line up";
        };
      }
      # Keep last yanked when pasting
      {
        key = "p";
        action = "\"_dP";
        mode = "v ";
        options = optionsDefaults // {
          desc = "Keep the last copied text after pasting";
        };
      }
      # Do not copy character when pressing x
      {
        key = "x";
        action = "\"_x";
        mode = "n";
        options = optionsDefaults // {
          desc = "Delete character without adding its content to the clipboard";
        };
      }
      # Diagnostics stuff
      {
        key = "<leader>do";
        mode = "n";
        action = "toggleDiagnostics()";
        options = optionsDefaults // {
          desc = "Toggle diagnostics on/off";
        };
      }
      {
        mode = "n";
        key = "[d";
        action = "vim.diagnostic.goto_prev";
        options = optionsDefaults // {
          desc = "Go to previous diagnostic message";
        };
      }
      {
        mode = "n";
        key = "]d";
        action = "vim.diagnostic.goto_next";
        options = optionsDefaults // {
          desc = "Go to next diagnostic message";
        };
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "vim.diagnostic.open_float";
        options = optionsDefaults // {
          desc = "Open floating diagnostic message";
        };
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "vim.diagnostic.setloclist";
        options = optionsDefaults // {
          desc = "Open diagnostics list";
        };
      }

    };
  };
}
