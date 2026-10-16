# The main user.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.nixos.core = {
    users = {
      users.${vars.user.name} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel"];
      };
    };
  };
}
