# System-wide session variables and packages.
{
  config,
  inputs,
  ...
}: let
  inherit (config) vars;
in {
  flake.modules.nixos.core = {pkgs, ...}: {
    environment = {
      variables = vars.sessionVariables;
      systemPackages = with pkgs; [
        inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default

        curl
        git
        neovim
        wget

        # Lets SSH sessions from kitty (TERM=xterm-kitty) work on hosts without
        # kitty, such as t14s.
        kitty.terminfo

        cacert
      ];
    };

    # Home Manager writes GTK settings (from Stylix) to dconf.
    programs.dconf.enable = true;
  };
}
