{ pkgs, config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    shellAliases = {
      # Navigate to nix config dir
      nkcd = "cd ${config.var.configDirectory}";

      # View images within kitty
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";

      # Eza overrides
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";
    };
  };
}
