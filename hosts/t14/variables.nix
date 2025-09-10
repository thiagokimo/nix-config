{config, inputs, ...}: {
  imports = [../common/variables-config.nix];
  config.var = {
    hostName = "t14";
    stateVersion = "25.05";
    wallpaper = inputs.nix-wallpapers + "/gruvbox/iuh3jkasndjans.jpg";
  };
}
