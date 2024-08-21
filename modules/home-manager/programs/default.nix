{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./cli
    ./design.nix
  ];
}
