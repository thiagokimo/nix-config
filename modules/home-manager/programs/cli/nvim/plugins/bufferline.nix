{
  programs.nixvim.plugins = {
    vim-bbye.enable = true;
    web-devicons.enable = true;

    bufferline = {
      enable = true;

      settings = {
        mode = "buffers";
          themable = true;
          numbers = "none";
          close_command = "Bdelete! %d";
          right_mouse_command = "Bdelete! %d";
          left_mouse_command = "buffer %d";
          middle_mouse_command = null;
          buffer_close_icon = "✗";
          close_icon = "";
          path_components = 1;
          modified_icon = "●";
          left_trunc_marker = "";
          right_trunc_marker = "";
          max_name_length = 30;
          max_prefix_length = 30;
          tab_size = 21;
          diagnostics = false;
          diagnostics_update_in_insert = false;
          color_icons = true;
          show_buffer_icons = true;
          show_buffer_close_icons = true;
          show_close_icon = true;
          persist_buffer_sort = true;
          separator_style = [ "│" "│" ];
          enforce_regular_tabs = true;
          always_show_bufferline = true;
          show_tab_indicators = false;
          indicator = {
            style = "none";
          };
          icon_pinned = "󰐃";
          minimum_padding = 1;
          maximum_padding = 5;
          maximum_length = 15;
          sort_by = "insert_at_end";
      };

      highlights = {
        separator = {
          fg = "#434C5E";
        };
        buffer_selected = {
          bold = true;
          italic = false;
        };
      };
    };
  };
}