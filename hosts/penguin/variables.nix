{config, ...}: {
  imports = [../common/variables.nix];

  config.var.hostname = "penguin";
}
