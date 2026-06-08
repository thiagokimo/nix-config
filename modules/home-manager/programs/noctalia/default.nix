{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  home.packages = [
    pkgs.hyprshot
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Gruvbox";
      };

      location = {
        auto_locate = false;
        address = "Belo Horizonte";
      };

      weather = {
        enabled = true;
        unit = "celsius";
        effects = true;
      };

      launcher = {
        terminal_command = "systemd-run --user --scope --collect --";
      };
    };
  };
}
