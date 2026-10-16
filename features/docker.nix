# Docker daemon with docker-compose. The main user joins the docker group to
# run containers without sudo.
{
  flake.modules.nixos.docker = {
    pkgs,
    vars,
    ...
  }: {
    virtualisation.docker = {
      enable = true;
    };

    users.users.${vars.user.name}.extraGroups = ["docker"];

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
