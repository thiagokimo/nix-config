{pkgs, ...}: {
  imports = [
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
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

    # Fun
    peaclock
    cbonsai
    pipes
    cmatrix
  ];
}
