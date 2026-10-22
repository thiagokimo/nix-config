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
# Workflows pick a runner with `runs-on: [self-hosted, <label>]`. A host that
# lists this feature runs the runners under its name below; those on t14s have
# the `t14s` label. The per-runner options replace the defaults in mkRunner.
{lib, ...}: let
  runnersByHost = {
    t14s = {
      nix-config = {};
      pixel-pong = {
        extraLabels = ["t14s" "pixel-pong"];
        # Two jobs at a time. Each replica gives the Firebase emulators in its
        # tests their own ports, picked from the `-<n>` suffix of RUNNER_NAME,
        # so the name has to keep ending in the replica number.
        count = 2;
        name = "t14s-pixel-pong";
      };
    };

    # Temporary, while t14s is without power: t14 stands in for its pixel-pong
    # runner. To revert, remove this entry and "github-runners" from the
    # features in hosts/t14/default.nix.
    t14 = {
      # Two replicas, like on t14s: services github-runner-pixel-pong-1 and -2,
      # runners t14-pixel-pong-1 and -2.
      pixel-pong = {
        extraLabels = ["pixel-pong"];
        count = 2;
        name = "t14-pixel-pong";
      };
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
  flake.modules.nixos.github-runners = {config, ...}: let
    runners = runnersByHost.${config.networking.hostName};
  in {
    services.github-runners = lib.mapAttrs mkRunner runners;

    # Jobs run nix, and allowed-users only lists the main user. These are the
    # DynamicUser names systemd gives each runner service: github-runner-<attr>
    # for a single runner, github-runner-<attr>-<n> for each of several.
    nix.settings.allowed-users = lib.concatLists (lib.mapAttrsToList (
        attr: options: let
          count = options.count or 1;
        in
          if count == 1
          then ["github-runner-${attr}"]
          else map (n: "github-runner-${attr}-${toString n}") (lib.range 1 count)
      )
      runners);
  };
}
