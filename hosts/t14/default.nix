{pkgs, ...}: let
  # Fix for Lenovo ThinkPad T14 Gen 2 (Intel) ACPI firmware bug:
  # SEN4._TMP (thermal sensor 4) calls the missing method _SB.PC00.RP09.PEGP.DDNT,
  # causing ACPI BIOS Error (AE_NOT_FOUND) and disabling thermal_zone6.
  acpiOverride = pkgs.runCommand "acpi-ddnt-fix" {
    nativeBuildInputs = [ pkgs.acpica-tools pkgs.cpio ];
  } ''
    cat << 'EOF' > ssdt-ddnt.dsl
    DefinitionBlock ("", "SSDT", 2, "LENOVO", "DDNTFIX", 0x00000001)
    {
        External (_SB.PC00.RP09.PEGP, DeviceObj)

        Scope (_SB.PC00.RP09.PEGP)
        {
            Method (DDNT, 1, NotSerialized)
            {
                Return (Zero)
            }
        }
    }
    EOF

    mkdir -p kernel/firmware/acpi
    iasl -p kernel/firmware/acpi/ssdt-ddnt.aml ssdt-ddnt.dsl
    find kernel | cpio -H newc -o > $out
  '';
in {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  boot.initrd.prepend = [ "${acpiOverride}" ];

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];
}
