{pkgs, ...}: {
  imports = [
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    less
    neofetch
    ranger
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
