{
  pkgs,
  vars,
  hostname,
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

      # Eza overrides
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";

      # Bat overrides
      cat = "bat";

      # nix-kimo legacy shortcuts
      hms = "home-manager switch --flake ${vars.path}.#${vars.username}@${hostname}";
      nrs = "sudo nixos-rebuild switch --flake ${vars.path}.#${hostname}";
    };
  };
}
