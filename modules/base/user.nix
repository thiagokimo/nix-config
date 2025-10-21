{
  configVars,
  pkgs,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${username} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
