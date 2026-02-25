{pkgs, ...}: {
  imports = [
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./yazi.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    less
    neofetch
    unzip
    zip
    bat
    btop
    wl-clipboard

    # Fun
    peaclock
    cbonsai
    pipes
    cmatrix
  ];
}
