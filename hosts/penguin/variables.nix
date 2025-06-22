{config, ...}: {
  imports = [../common/variables.nix];

  config.var.hostname = "penguin";
  theme = import ../../themes/var/default.nix;
}
