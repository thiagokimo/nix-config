# Kitty, the terminal.
{
  flake.modules.homeManager.desktop = {
    programs.kitty = {
      enable = true;
      settings = {
        scrollback_lines = 10000;
        initial_window_width = 1200;
        initial_window_height = 600;
        update_check_interval = 0;
        enable_audio_bell = false;
        confirm_os_window_close = "0";
        remember_window_size = "no";
        disable_ligatures = "never";
        url_style = "curly";
        cursor_shape = "Underline";
        cursor_underline_thickness = 3;
        window_padding_width = 10;
        linux_display_server = "auto";
      };
    };

    # ssh goes through kitty's ssh kitten, which tints the window red while
    # connected to t14s (by name, Tailscale name or Tailscale IP) and restores
    # the colors on exit. Outside kitty, plain ssh is used.
    xdg.configFile."kitty/ssh.conf".text = ''
      hostname t14s t14s.* 100.115.181.106
      color_scheme ssh-server.conf
    '';
    xdg.configFile."kitty/ssh-server.conf".text = ''
      background #2b1416
    '';

    programs.zsh.initContent = ''
      [[ -n $KITTY_WINDOW_ID ]] && alias ssh="kitten ssh"
    '';
  };
}
