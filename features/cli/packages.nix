# Command-line utilities, and a few toys.
{
  flake.modules.homeManager.cli = {pkgs, ...}: {
    home.packages = with pkgs; [
      less
      unzip
      zip
      p7zip
      unrar
      bat
      btop
      wl-clipboard

      # Fun
      peaclock
      cbonsai
      pipes
      cmatrix
      ani-cli
    ];
  };
}
