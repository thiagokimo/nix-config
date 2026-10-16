# A per-user SSH agent, started by systemd with the user's session, that keeps
# the key unlocked after its first use in a terminal.
{
  flake.modules.homeManager.ssh-agent = {
    # Socket at $XDG_RUNTIME_DIR/ssh-agent. Home Manager exports SSH_AUTH_SOCK
    # from .zshenv and .zprofile, so non-interactive shells get it too.
    services.ssh-agent.enable = true;

    # The first ssh to GitHub asks for the passphrase and hands the key to the
    # agent, so later pushes (from shells without a TTY too) don't ask again.
    programs.ssh.settings."github.com".AddKeysToAgent = "yes";
  };
}
