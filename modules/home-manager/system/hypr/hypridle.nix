{pkgs, ...}: let
  lock-cmd = "lock-hypr";
in {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = lock-cmd;
      };
      listener = [
        {
          timeout = 900;
          on-timeout = lock-cmd;
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
