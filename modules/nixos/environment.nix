{
  pkgs,
  vars,
  ...
}: {
  environment = {
    variables = {
      XDG_DATA_HOME = "/home/${vars.username}/.local/share";
      EDITOR = "${vars.editor}";
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
