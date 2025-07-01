{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
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

    # Fun
    peaclock
    cbonsai
    pipes
    cmatrix
  ];
}
