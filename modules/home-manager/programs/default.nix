{pkgs, ...}: {
  imports = [
    ./cli
    ./design.nix
  ];

  home.packages = with pkgs; [
    firefox # Internet browser
  ];
}
