{...}: {
  imports = [
    ./bat.nix             # Better printer
    ./btop.nix            # Resource monitor
    ./git.nix             # Version control
    ./kitty.nix           # Terminal emulator 
    ./neovim.nix          # File editor
    ./zsh.nix             # Shell

    ./cli-packages.nix    # CLI softwares
    ./design-packages.nix # Design softwares
    ./web-packages.nix    # Web softwares
    ./scripts             # Custom scripts
  ];  
}
