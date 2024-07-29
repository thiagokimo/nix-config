#!/bin/sh
nix build $HOME/dotfiles/nix#homeConfigurations.thiago.activationPackage
result/activate
rm result
