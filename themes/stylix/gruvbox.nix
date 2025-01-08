{
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = {
      base00 = "1d2021"; # black hard
      base01 = "928374"; # black
      base02 = "cc241d"; # red hard
      base03 = "fb4934"; # red
      base04 = "98971a"; # green hard
      base05 = "b8bb26"; # green
      base06 = "d79921"; # yellow hard
      base07 = "fabd2f"; # yellow
      base08 = "458588"; # blue hard
      base09 = "83a598"; # blue
      base0A = "b16286"; # magenta hard
      base0B = "d3869b"; # magenta
      base0C = "689d6a"; # cyan hard
      base0D = "8ec07c"; # cyan
      base0E = "a89984"; # white hard
      base0F = "ebdbb2"; # white
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 16;
        desktop = 16;
        popups = 16;
        terminal = 16;
      };
    };

    polarity = "dark";
    image = inputs.nix-wallpapers + "/gruvbox/boxes.png";
  };
}
