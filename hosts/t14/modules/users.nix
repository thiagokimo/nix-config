{pkgs, ...}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.thiago = {
      isNormalUser = true;
      description = "Thiago";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
    };
  };
}
