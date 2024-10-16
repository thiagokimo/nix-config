{
  config,
  pkgs,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${config.var.username} = {
      isNormalUser = true;
      description = "${config.var.username}'s account";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
