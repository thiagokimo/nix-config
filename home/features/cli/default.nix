{pkgs, ...}: {
  imports = [
    import
    ./bat.nix
    import
    ./git.nix
    import
    ./neovim.nix
    import
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
