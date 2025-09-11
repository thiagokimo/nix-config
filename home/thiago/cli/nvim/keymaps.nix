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

    keymaps = [
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
          desc = "Scroll down and center";
        };
      }
      {
        key = "<C-u>";
        action = "<C-u>zz";
        mode = "n";
        options = optionsDefaults // {
          desc = "Scroll up and center";
        };
      }
      # Resize windows with arrows
      {
        key = "<Up>";
        action = ":resize -2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Decrease the size of the buffer horizontally";
        };
      }
      {
        key = "<Down>";
        action = ":resize +2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Increase the size of the buffer horizontally";
        };
      }
      {
        key = "<Left>";
        action = ":vertical resize +2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Increase the size of the buffer on the right";
        };
      }
      {
        key = "<Right>";
        action = ":vertical resize -2<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Increase the size of the buffer on the left";
        };
      }
      # Buffers
      {
        key = "<Tab>";
        action = ":bnext<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Navigate to the next buffer";
        };
      }
      {
        key = "<S-Tab>";
        action = ":bprevious<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Navigate to the previous buffer";
        };
      }
      {
        key = "<leader>x";
        action = ":Bdelete!<CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "Close buffer";
        };
      }
      {
        key = "<leader>b";
        action = "<cmd> enew <CR>";
        mode = "n";
        options = optionsDefaults // {
          desc = "New buffer";
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
    ];
  };
}
