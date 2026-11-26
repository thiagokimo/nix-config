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

    # Self-hosted services answer at <name>.lan, see features/proxy.nix.
    lanDomain = "lan";

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
      # Features every host gets, the servers included.
      base = ["cli" "core" "firmware" "nvim" "ssh" "stylix" "tailscale" "zsh"];
      # Features for the laptops I carry around: what a desk needs (sound,
      # Bluetooth, the keyboard remap) and the development tools.
      laptop = ["ai" "audio" "bluetooth" "desktop" "docker" "gaming" "hyprland" "kanata" "painel" "ssh-agent"];
    };
  };
}
