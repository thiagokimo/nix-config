{pkgs, ...}: {
  imports = [
    ./eza.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./yazi.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    less
    unzip
    zip
    p7zip
    unrar
    bat
    btop
    wl-clipboard

    # Fun
    peaclock
    cbonsai
    pipes
    cmatrix
    ani-cli
  ];
}
