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
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        # theme = "robbyrussell";
        theme = "ys";
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
  };
}
