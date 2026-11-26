# Reboots a hung server instead of leaving it frozen until someone is home.
# - systemd pets the board's hardware watchdog (bcm2835_wdt on the pi, 15s at
#   most; Intel's on the t14s); if the kernel or systemd freezes and stops petting it, the
#   hardware resets the machine after 10s. The same timer covers a reboot that
#   stalls on the way down.
# - The kernel reboots 10 seconds after a panic, which NixOS otherwise leaves
#   hung on the screen.
# After one of these, `journalctl --list-boots` shows the new boot and
# `journalctl -b -1` ends abruptly where the old one died.
{
  flake.modules.nixos.watchdog = {
    systemd.settings.Manager = {
      RuntimeWatchdogSec = "10s";
      RebootWatchdogSec = "10s";
    };
    boot.kernelParams = ["panic=10"];
  };
}
