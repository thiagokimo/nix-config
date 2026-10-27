# Values for the `vars` option declared in modules/flake/vars.nix.
{config, ...}: {
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

    featureSets = {
      # Features every host gets.
      base = ["ai" "audio" "bluetooth" "cli" "core" "docker" "firmware" "kanata" "nvim" "ssh" "stylix" "tailscale" "zsh"];
      # Features for the laptops I carry around.
      laptop = ["desktop" "gaming" "hyprland"];
    };
  };
}
