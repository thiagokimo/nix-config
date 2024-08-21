{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.initrd.luks.devices."luks-7c212fe7-7b5d-41b4-980b-371ceec34454".device = "/dev/disk/by-uuid/7c212fe7-7b5d-41b4-980b-371ceec34454";
}
