{pkgs, inputs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = {
      base00 = "202020";
      base01 = "2a2827";
      base02 = "504945";
      base03 = "5a524c";
      base04 = "bdae93";
      base05 = "ddc7a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "ea6962";
      base09 = "e78a4e";
      base0A = "d8a657";
      base0B = "a9b665";
      base0C = "89b482";
      base0D = "7daea3";
      base0E = "d3869b";
      base0F = "bd6f3e";    
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      # monospace = {
      #   package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      #   name = "JetBrains Mono Nerd Font";
      # };
      # sansSerif = {
      #   package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
      #   name = "SFProDisplay Nerd Font";
      # };
      # serif = {
      #   package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
      #   name = "SFProDisplay Nerd Font";
      # };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };
    
    polarity = "dark";
    image = inputs.nix-wallpapers + "/wallpapers/jxzzlw.jpg";
  };
}
