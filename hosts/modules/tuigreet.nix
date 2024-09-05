{pkgs, ..}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --asterisks --container-padding 2 --time-format '%I:%M %p | %a · %h | %F' --command Hyprland";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [greetd.tuigreet];

  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Avoid errors on screen

    # Avoid bootlogs on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVDisallocate = true;
  };

  # Prevent freeze at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
