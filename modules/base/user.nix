{
  configVars,
  pkgs,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${configVars.username} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
