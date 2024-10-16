{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      roboto
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      nerdfonts
      # (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; })
    ];

    # enableDefaultPackages = false;

    # fontconfig = {
    #   defaultFonts = {
    #     monospace = [ "FiraCode Nerd Font Mono" "Noto Color Emoji" ];
    #     sansSerif = [ "SFProDisplay Nerd Font" "Noto Color Emoji" ];
    #     serif = [ "SFProDisplay Nerd Font" "Noto Color Emoji" ];
    #     emoji = [ "Noto Color Emoji" ];
    #   };
    # };
  };
}
