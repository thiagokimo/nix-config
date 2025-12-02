{
  pkgs,
  configVars,
  ...
}: {
  environment = {
    variables = {
      XDG_DATA_HOME = "/home/${configVars.username}/.local/share";
      EDITOR = "${configVars.editor}";
    };
    systemPackages = with pkgs; [
      bluetui
      curl
      git
      neovim
      xdg-utils
      wget

      # MTP stuff
      jmtpfs
      libmtp
      simple-mtpfs
    ];
  };
}
