# Values for the `vars` option declared in modules/flake/vars.nix.
{config, ...}: let
  # Features every host gets.
  base = ["audio" "docker" "kanata" "zsh"];
  # Features for the laptops I carry around.
  laptop = ["desktop" "gaming" "hyprland"];
in {
  vars = {
    user = {
      name = "thiago";
      email = "kimo@kimo.io";
    };

    system = {
      stateVersion = "26.11";
    };

    sessionVariables = {
      EDITOR = config.vars.defaults.editor.bin;
      XDG_DATA_HOME = "${config.vars.user.home}/.local/share";
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
        features = base ++ laptop;
        display = {
          output = "eDP-1";
          width = 2256;
          height = 1504;
        };
      };
      t14 = {
        system = "x86_64-linux";
        features = base ++ laptop;
        display = {
          output = "eDP-1";
          width = 1920;
          height = 1080;
        };
      };
      # Home server: headless, reached over SSH.
      t14s = {
        system = "x86_64-linux";
        features = base;
      };
    };
  };
}
