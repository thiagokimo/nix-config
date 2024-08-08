{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    less
    neofetch
    ranger
    unzip
    zip
  ];
}
