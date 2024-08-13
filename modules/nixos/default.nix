{pkgs, ...}: {
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [zsh];
    systemPackages = with pkgs; [
      curl
      firefox
      git
      hyprland
      kitty
      vim
      wget
    ];
  };
}
