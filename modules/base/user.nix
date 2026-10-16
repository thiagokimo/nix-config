{vars, ...}: {
  users = {
    users.${vars.user.name} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput"];
    };
  };
}
