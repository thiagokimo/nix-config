{
  pkgs,
  inputs,
  vars,
  ...
}: {
  environment = {
    variables = {
      XDG_DATA_HOME = "/home/${vars.username}/.local/share";
      EDITOR = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      inputs.home-manager.packages.${pkgs.system}.default

      bluetui
      curl
      git
      neovim
      xdg-utils
      wget

      jmtpfs
      libmtp
      simple-mtpfs

      wineWow64Packages.stable
      winetricks
      zenity
      bottles

      cacert
    ];
  };
}
