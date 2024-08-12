{...}: {
  users.users.thiago = {
    isNormalUser = true;
    description = "Thiago";
    extraGroups = ["networkmanager" "wheel"];
  };
}
