# zsh as the shell of every user: the NixOS side makes it the login shell, the
# Home Manager side configures it.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.zsh = {pkgs, ...}: {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };

  flake.modules.homeManager.zsh = {
    config,
    lib,
    ...
  }: let
    host = vars.hosts.${config.host.name};
    # Starship palette names are lowercase (stylix's base16 palette).
    accent = lib.toLower host.accent;
  in {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        # Starship draws the prompt instead of an oh-my-zsh theme.
        theme = "";
      };

      shellAliases = {
        # Navigate to nix config dir
        nkcd = "cd ${vars.user.configDir}";

        # TODO Verify if nh,bat,eza and any other software is installed before adding these aliases

        # Eza overrides
        ls = "eza --icons=always --no-quotes";
        tree = "eza --icons=always --tree --no-quotes";

        # Bat overrides
        cat = "bat";
        man = "MANROFFOPT=\"-c\" MANPAGER=\"sh -c 'col -bx | bat -l man -p'\" man";

        # nh shortcuts
        hms = "nh home switch";
        nrs = "nh os switch";

        # Firmware update
        fwup = "firmware-update";
        fw-update = "firmware-update";
      };
    };

    # The prompt, styled like the noctalia bar islands. It opens with the host:
    # a quiet island locally, and over SSH a solid pill in the host's accent
    # color (the same one kitty tints the window with), so a remote prompt
    # stands out.
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = let
        # The SSH host badge: a solid pill in the host's accent.
        pill = color: content: "[](fg:${color})[${content}](bg:${color} fg:base00)[](fg:${color})";
        # Everything else matches the noctalia bar islands: one dark surface,
        # with color carried by the glyphs rather than the fill.
        island = content: "[](fg:base01)${content}[](fg:base01)";
      in {
        add_newline = true;
        format = lib.concatStrings [
          "$hostname"
          "\${custom.host}"
          " $directory"
          "( $git_branch$git_status)"
          "( $nix_shell)"
          "$fill"
          "( $cmd_duration)"
          " $time"
          "\n$character"
        ];

        hostname = {
          ssh_only = true;
          ssh_symbol = "${host.icon} ";
          format = pill accent " $ssh_symbol$hostname ";
          style = "bold";
        };
        # The same badge as a quiet island when local. Starship can't hide a
        # module while a variable is set, so a cheap sh test decides.
        custom.host = {
          when = ''[ -z "$SSH_CONNECTION" ]'';
          shell = ["sh"];
          format = island "[ ${host.icon} ](bg:base01 fg:${accent})[${config.host.name} ](bg:base01 fg:base05)";
        };
        directory = {
          format = island "[ $path](bg:base01 fg:base05)[$read_only](bg:base01 fg:red)";
          read_only = " 󰌾";
          truncation_length = 3;
          truncation_symbol = "…/";
        };
        git_branch = {
          symbol = " ";
          format = "[](fg:base01)[$symbol](bg:base01 fg:orange)[$branch](bg:base01 fg:base05)";
        };
        git_status = {
          format = "[( $all_status$ahead_behind)](bg:base01 fg:yellow)[](fg:base01)";
        };
        nix_shell = {
          symbol = " ";
          format = island "[$symbol](bg:base01 fg:blue)[$name](bg:base01 fg:base05)";
        };
        fill.symbol = " ";
        cmd_duration = {
          min_time = 2000;
          format = "[󱎫 $duration](fg:yellow)";
        };
        time = {
          disabled = false;
          time_format = "%H:%M";
          format = "[ $time](fg:base03)";
        };
        character = {
          success_symbol = "[❯](bold ${accent})";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };
      };
    };

    # Over SSH, the window title starts with the host ("󰒋 t14s · ~/src"), so
    # it stays identifiable in the task bar and Hyprland can color its border.
    # Kitty's own titles are turned off for these sessions, see kitty.nix.
    programs.zsh.initContent = ''
      if [[ -n $SSH_CONNECTION ]]; then
        DISABLE_AUTO_TITLE=true
        _host_title() { print -Pn "\e]2;${host.icon} %m · $1\a" }
        _host_title_precmd() { _host_title "%~" }
        _host_title_preexec() { _host_title "''${1//\%/%%}" }
        autoload -Uz add-zsh-hook
        add-zsh-hook precmd _host_title_precmd
        add-zsh-hook preexec _host_title_preexec
      fi
    '';
  };
}
