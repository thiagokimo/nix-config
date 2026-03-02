{
  pkgs,
  vars,
  ...
}: {
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
      nkcd = "cd ${vars.path}";

      # TODO Verify if nh,bat,eza and any other software is installed before adding these aliases

      # Eza overrides
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";

      # Bat overrides
      cat = "bat";

      # nix-kimo legacy shortcuts
      hms = "nh home switch";
      nrs = "nh os switch";
    };
  };
}
