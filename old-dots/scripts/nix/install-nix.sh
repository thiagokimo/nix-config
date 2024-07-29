#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

git clone https://github.com/thiagokimo/dotfiles.git $HOME/dotfiles

mkdir -p $HOME/.config/nix
echo 'experimental-features = nix-command flakes' >> $HOME/.config/nix/nix.conf
