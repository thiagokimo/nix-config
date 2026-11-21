# Placeholder until NixOS runs on the Pi: the layout of the official NixOS
# aarch64 SD image written to the M.2 SSD, which labels its partitions. Replace
# it with `nixos-generate-config --show-hardware-config` from the Pi.
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = ["noatime"];
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
    options = ["nofail" "noauto"];
  };

  boot.initrd.availableKernelModules = ["xhci_pci" "usb_storage" "uas"];

  swapDevices = [];
}
