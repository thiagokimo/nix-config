{
  programs.nixvim = {
    nvim-web-devicons.enable = true;

    plugins = {
      lualine = {
        enable = true; # Enable the Lualine plugin

        # Dependencies for Lualine.
        # In this case, only 'nvim-web-devicons'.
        # Ensure this plugin is also enabled somewhere in your overall Nixvim configuration.
        dependencies = [ "nvim-web-devicons" ];

        # The 'config' function in Lua.
        # Everything inside `require('lualine').setup { ... }` goes into 'settings'.
        # The Lua functions defined before the setup call (like `hide_in_width`, `mode`, `filename`, `diagnostics`, `diff`)
        # need to be integrated into the settings as multi-line strings where they are used,
        # or defined as global Lua functions via `extraConfigLua` if they are reusable.
        # For Lualine, it's often cleaner to define them directly within the setup's settings.

        # Lualine settings
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
            # Define 'mode' component with its custom fmt function
            lualine_a = [
              {
                "mode";
                fmt = ''
                  function(str)
                    -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
                    return ' ' .. str
                  end
                '';
              }
            ];
            lualine_b = [ "branch" ];
            # Define 'filename' component
            lualine_c = [
              {
                "filename";
                file_status = true;
                path = 0;
              }
            ];
            # Define 'diagnostics', 'diff', 'encoding', 'filetype' for lualine_x
            lualine_x = [
              # Diagnostics component
              {
                "diagnostics";
                sources = [ "nvim_diagnostic" ];
                sections = [ "error" "warn" ];
                symbols = { error = " "; warn = " "; info = " "; hint = " "; };
                colored = false;
                update_in_insert = false;
                always_visible = false;
                # The 'cond' function needs to be embedded as a Lua string
                cond = ''
                  function()
                    return vim.fn.winwidth(0) > 100
                  end
                '';
              }
              # Diff component
              {
                "diff";
                colored = false;
                symbols = { added = " "; modified = " "; removed = " "; };
                # The 'cond' function needs to be embedded as a Lua string
                cond = ''
                  function()
                    return vim.fn.winwidth(0) > 100
                  end
                '';
              }
              # Encoding component
              {
                "encoding";
                # The 'cond' function needs to be embedded as a Lua string
                cond = ''
                  function()
                    return vim.fn.winwidth(0) > 100
                  end
                '';
              }
              # Filetype component
              {
                "filetype";
                # The 'cond' function needs to be embedded as a Lua string
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
          inactive_sections = {
            lualine_a = {};
            lualine_b = {};
            lualine_c = [
              { "filename"; path = 1; }
            ];
            lualine_x = [
              { "location"; padding = 0; }
            ];
            lualine_y = {};
            lualine_z = {};
          };
          tabline = {}; # Empty table translates to empty attribute set
        };
      };
    };
  };
}