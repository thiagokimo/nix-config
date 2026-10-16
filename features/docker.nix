# Docker daemon with docker-compose. The main user joins the docker group to
# run containers without sudo.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.docker = {pkgs, ...}: {
    virtualisation.docker = {
      enable = true;
    };

    users.users.${vars.user.name}.extraGroups = ["docker"];

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
