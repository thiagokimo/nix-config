{
  pkgs,
  inputs,
  vars,
  ...
}: {
  environment = {
    variables = vars.sessionVariables;
    systemPackages = with pkgs; [
      inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default

      bluetui
      curl
      git
      neovim
      wget

      # Lets SSH sessions from kitty (TERM=xterm-kitty) work on hosts without
      # kitty, such as t14s.
      kitty.terminfo

      cacert
    ];
  };
}
