{pkgs, ...}: {
  # This was only added here to make zsh available in /etc/shells
  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [zsh];
    systemPackages = with pkgs; [
      curl
      git
      vim
      wget
    ];
  };
}
