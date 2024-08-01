{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    htop
    less
    neofetch
    ranger
    unzip
    zip
  ];
}
