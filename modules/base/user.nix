{
  vars,
  pkgs,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${vars.username} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput"];
    };
  };
}
