let
  user = "thiago";
  home = "/home/${user}";
in {
  user = {
    name = user;
    email = "kimo@kimo.io";
    home = home;
    configDir = "${home}/.config/nix-config";
  };

  system = {
    stateVersion = "26.11";
  };

  defaults = {
    terminal = {
      bin = "kitty";
      desktop = "kitty.desktop";
    };
    editor = {
      bin = "nvim";
      desktop = "nvim.desktop";
    };
    browser = {
      bin = "google-chrome-stable";
      desktop = "google-chrome.desktop";
    };
    fileManager = {
      bin = "nautilus";
      desktop = "org.gnome.Nautilus.desktop";
    };
    imageViewer = {
      desktop = "org.gnome.Loupe.desktop";
    };
    pdfViewer = {
      desktop = "org.gnome.Papers.desktop";
    };
    mediaPlayer = {
      desktop = "vlc.desktop";
    };
  };

  hosts = {
    framework = {
      system = "x86_64-linux";
      display = {
        output = "eDP-1";
        width = 2256;
        height = 1504;
      };
    };
    t14 = {
      system = "x86_64-linux";
      display = {
        output = "eDP-1";
        width = 1920;
        height = 1080;
      };
    };
    t14s = {
      system = "x86_64-linux";
      display = {
        output = "eDP-1";
        width = 1920;
        height = 1080;
      };
    };
  };
}
