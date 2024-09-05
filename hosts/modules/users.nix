{
  config,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username;};
    users.${username} = {
      imports = [../home-manager];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.${config.var.username} = {
      isNormalUser = true;
      description = "${config.var.username}'s account";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
