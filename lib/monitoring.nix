# Helpers for the checks that service features add to Gatus on the monitoring
# host (features/monitoring.nix).
{
  # Where the monitoring host (self) reaches the services of host `name`: over
  # loopback for its own, so a Tailscale hiccup doesn't fail them, and at the
  # Tailscale address for the others'.
  address = self: name: host:
    if name == self
    then "127.0.0.1"
    else host.tailscaleIp;
}
