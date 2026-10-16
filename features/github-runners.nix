# Self-hosted GitHub Actions runners, one per repository: a personal account
# can't share a runner between repositories.
#
# Each repository needs a fine-grained PAT with "Administration: read and
# write" on that repository only. The service mints registration tokens from
# it. Write it root-only, with no trailing newline:
#
#   sudo install -d -m 0700 /etc/github-runner
#   echo -n 'github_pat_…' | sudo tee /etc/github-runner/<repo>.token >/dev/null
#   sudo chmod 0600 /etc/github-runner/<repo>.token
#
# Workflows pick a runner with `runs-on: [self-hosted, <label>]`. Every runner
# has the `t14s` label. The per-repository options below replace the defaults
# in mkRunner.
{lib, ...}: let
  repos = {
    nix-config = {};
    pixel-pong = {
      extraLabels = ["t14s" "pixel-pong"];
      # One job at a time: the Firebase emulators in its tests use fixed ports.
      count = 1;
    };
  };

  mkRunner = repo: options:
    {
      enable = true;
      url = "https://github.com/thiagokimo/${repo}";
      tokenFile = "/etc/github-runner/${repo}.token";
      extraLabels = ["t14s"];
      # Re-registering under the same name replaces the old entry, e.g. after a
      # reinstall.
      replace = true;
    }
    // options;
in {
  flake.modules.nixos.github-runners = {
    services.github-runners = lib.mapAttrs mkRunner repos;

    # Jobs run nix, and allowed-users only lists the main user. These are the
    # DynamicUser names systemd gives each runner service.
    nix.settings.allowed-users = map (repo: "github-runner-${repo}") (lib.attrNames repos);
  };
}
