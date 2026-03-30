{pkgs, inputs, ...}: {
  imports = [inputs.noctalia.homeModules.default];

  programs.noctalia-shell = {
    enable = true;
    settings = {
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
        terminalCommand = "${pkgs.kitty}/bin/kitty -e";
      };
    };
  };
}
