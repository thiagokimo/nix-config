{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
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
