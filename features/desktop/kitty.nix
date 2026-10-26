# Kitty, the terminal.
{
  config,
  lib,
  ...
}: let
  inherit (config) vars;
  inherit (import ../../lib/colors.nix) mix;
in {
  flake.modules.homeManager.desktop = {config, ...}: let
    c = config.lib.stylix.colors;

    # The colors kitty switches to while an SSH session to `host` is open: the
    # host's accent tints the background and drives the cursor, selection and
    # tabs, so a remote window can't pass for a local one.
    sshScheme = host: let
      accent = c.${host.accent};
    in ''
      background #${mix c.base00 accent 0.15}
      cursor #${accent}
      cursor_text_color #${c.base00}
      selection_background #${mix c.base00 accent 0.45}
      selection_foreground #${c.base07}
      active_border_color #${accent}
      active_tab_background #${accent}
      active_tab_foreground #${c.base00}
      inactive_tab_background #${mix c.base00 accent 0.3}
      inactive_tab_foreground #${c.base05}
      tab_bar_background #${mix c.base00 accent 0.1}
    '';

    sshHost = name: host: ''
      hostname ${lib.concatStringsSep " " ([name "${name}.*"] ++ lib.optional (host.tailscaleIp != null) host.tailscaleIp)}
      color_scheme ssh-${name}.conf
      # the remote shell titles the window with the host instead, see zsh.nix
      shell_integration enabled no-title
    '';
  in {
    # Text stays opaque; Hyprland blurs what shows through the background.
    stylix.opacity.terminal = 0.9;

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
        cursor_trail = 3;
        window_padding_width = 12;
        linux_display_server = "auto";
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        tab_title_template = "{index}: {title}";
      };
    };

    # ssh goes through kitty's ssh kitten, which switches to the remote host's
    # colors (matched by name, Tailscale name or Tailscale IP) and restores them
    # on exit. Outside kitty, plain ssh is used.
    xdg.configFile =
      {"kitty/ssh.conf".text = lib.concatStrings (lib.mapAttrsToList sshHost vars.hosts);}
      // lib.mapAttrs' (name: host: lib.nameValuePair "kitty/ssh-${name}.conf" {text = sshScheme host;}) vars.hosts;

    programs.zsh.initContent = ''
      [[ -n $KITTY_WINDOW_ID ]] && alias ssh="kitten ssh"
    '';
  };
}
