{
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    lualine = {
      enable = true;

      settings = {
        options = {
          theme = "auto";
          icons_enabled = true;
          section_separators = { left = ""; right = ""; };
          component_separators = { left = ""; right = ""; };
          disabled_filetypes = [ "alpha" "neo-tree" "Avante" ];
          always_divide_middle = true;
        };
        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              fmt = ''
                function(str)
                  -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
                  return ' ' .. str
                end
              '';
            }
          ];
          lualine_b = [ "branch" ];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              file_status = true;
              path = 0;
            }
          ];

          lualine_x = [
            {
              __unkeyed-1 = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              sections = [ "error" "warn" ];
              symbols = { error = " "; warn = " "; info = " "; hint = " "; };
              colored = false;
              update_in_insert = false;
              always_visible = false;
              cond = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }
            {
              __unkeyed-1 = "diff";
              colored = false;
              symbols = { added = " "; modified = " "; removed = " "; };
              cond = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }
            {
              __unkeyed-1 = "encoding";
              cond = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }
            {
              __unkeyed-1 = "filetype";
              cond = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }
          ];
          lualine_y = [ "location" ];
          lualine_z = [ "progress" ];
        };
        inactiveSections = {
          lualine_a = {};
          lualine_b = {};
          lualine_c = [
            { __unkeyed-1 = "filename"; path = 1; }
          ];
          lualine_x = [
            { __unkeyed-1 = "location"; padding = 0; }
          ];
          lualine_y = {};
          lualine_z = {};
        };
        tabline = {};
      };
    };
  };
}