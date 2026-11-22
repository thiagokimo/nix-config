# A per-user SSH agent, started by systemd with the user's session, that keeps
# the key unlocked after its first use in a terminal. SSH sessions into hosts
# with forwardAgent take the agent along.
{
  config,
  lib,
  ...
}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.ssh-agent = {config, ...}: let
    # Hosts that get the agent, matched like kitty's SSH colors: by name,
    # Tailscale name or Tailscale IP. Not this host itself.
    forwardTo = lib.filterAttrs (name: host: host.forwardAgent && name != config.host.name) vars.hosts;
    patterns = name: host: lib.concatStringsSep " " ([name "${name}.*"] ++ lib.optional (host.tailscaleIp != null) host.tailscaleIp);
  in {
    # Socket at $XDG_RUNTIME_DIR/ssh-agent. Home Manager exports SSH_AUTH_SOCK
    # from .zshenv and .zprofile, so non-interactive shells get it too.
    services.ssh-agent.enable = true;

    programs.ssh.settings =
      {
        # The first ssh to GitHub asks for the passphrase and hands the key to
        # the agent, so later pushes (from shells without a TTY too) don't ask
        # again.
        "github.com".AddKeysToAgent = "yes";
      }
      # Logging in with the key also hands it to the agent, so it is there to
      # forward even before the first push to GitHub.
      // lib.mapAttrs' (name: host:
        lib.nameValuePair (patterns name host) {
          ForwardAgent = "yes";
          AddKeysToAgent = "yes";
        })
      forwardTo;
  };
}
