{
  vars,
  pkgs,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${vars.user.name} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "docker"];
    };
  };
}
