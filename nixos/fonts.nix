{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      nerdfonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        sansSerif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        serif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
