{
  pkgs,
  inputs,
  vars,
  ...
}: {
  environment = {
    variables = {
      XDG_DATA_HOME = "${vars.user.home}/.local/share";
      EDITOR = vars.defaults.editor.bin;
    };
    systemPackages = with pkgs; [
      inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default

      bluetui
      curl
      git
      neovim
      xdg-utils
      wget

      libmtp
      simple-mtpfs

      wineWow64Packages.stable
      winetricks
      zenity

      cacert
    ];
  };
}
