{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      nerd-fonts.jetbrains-mono
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        sansSerif = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        serif = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
