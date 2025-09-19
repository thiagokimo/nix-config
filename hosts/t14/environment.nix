{
  pkgs,
  config,
  ...
}: {
  environment = {
    variables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      EDITOR = config.var.editor;
    };
    systemPackages = with pkgs; [
      curl
      git
      vim
      xdg-utils
      wget
    ];
  };
}
