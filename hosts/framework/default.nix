# Framework Laptop 13 (AMD).
{config, ...}: {
  vars.hosts.framework = {
    system = "x86_64-linux";
    features = with config.vars.featureSets; base ++ laptop;
    display = {
      output = "eDP-1";
      width = 2256;
      height = 1504;
    };

    nixos = {
      imports = [
        ./_hardware-configuration.nix
      ];
    };
  };
}
