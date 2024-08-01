{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # TODO find out why autosuggestions got broken
    autosuggestion.enable = true;

    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };
  };
}
