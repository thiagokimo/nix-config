{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  home.packages = [
    pkgs.hyprshot
  ];

  xdg.configFile."noctalia/plugins.json".force = true;

  programs.noctalia-shell = {
    enable = true;
    settings = {
      theme = {
        colorScheme = "gruvbox";
        variant = "dark";
      };

      location = {
        name = "Belo Horizonte";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = true;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        hideWeatherTimezone = false;
        hideWeatherCityName = false;
      };
      appLauncher = {
        terminalCommand = "systemd-run --user --scope --collect --";
      };
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        screenshot = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
