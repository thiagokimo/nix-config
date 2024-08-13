{pkgs, ...}: {
  imports = [
    ./kitty.nix
  ];
  # This was only added here to make zsh available in /etc/shells
  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [zsh];
    systemPackages = with pkgs; [
      curl
      firefox
      git
      hyprland
      vim
      wget
    ];
  };
}
