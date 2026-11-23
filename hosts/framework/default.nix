# Framework Laptop 13 (AMD Ryzen 7040).
{
  config,
  inputs,
  ...
}: {
  vars.hosts.framework = {
    system = "x86_64-linux";
    features = with config.vars.featureSets; base ++ laptop;
    accent = "base0A";
    display = {
      output = "eDP-1";
      width = 2256;
      height = 1504;
    };

    nixos = {
      imports = [
        ./_hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      programs.captive-browser.interface = "wlp1s0";
    };
  };
}
