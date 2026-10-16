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
      xdg-utils
      wget

      libmtp

      wineWow64Packages.stable
      winetricks
      zenity

      cacert
    ];
  };
}
