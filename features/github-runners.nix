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

    # Standby for t14s, see standbyFor below.
    t14 = {
      # Two replicas, like on t14s: services github-runner-pixel-pong-1 and -2,
      # runners t14-pixel-pong-1 and -2.
      pixel-pong = {
        extraLabels = ["pixel-pong"];
        count = 2;
        name = "t14-pixel-pong";
        # The runners can stay off for weeks, and GitHub deletes a runner that
        # has been offline that long, leaving the saved registration stale. An
        # ephemeral runner registers afresh on each start and takes one job per
        # registration, and GitHub drops it soon after it goes offline.
        ephemeral = true;
      };
    };
  };

  # GitHub has no priority between runners with the same labels, so a standby
  # host keeps its runners off while the primary answers over Tailscale. t14
  # is a work laptop and should only take jobs when t14s is down.
  standbyFor = {
    t14 = "t14s";
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
    config,
    pkgs,
    ...
  }: let
    hostName = config.networking.hostName;
    runners = runnersByHost.${hostName};

    # The runner services, which are also the DynamicUser names systemd gives
    # them: github-runner-<attr> for a single runner, github-runner-<attr>-<n>
    # for each of several.
    services = lib.concatLists (lib.mapAttrsToList (
        attr: options: let
          count = options.count or 1;
        in
          if count == 1
          then ["github-runner-${attr}"]
          else map (n: "github-runner-${attr}-${toString n}") (lib.range 1 count)
      )
      runners);
  in
    lib.mkMerge [
      {
        services.github-runners = lib.mapAttrs mkRunner runners;

        # Jobs run nix, and allowed-users only lists the main user.
        nix.settings.allowed-users = services;
      }

      (lib.mkIf (standbyFor ? ${hostName}) (let
        primary = standbyFor.${hostName};
        systemctl = "${config.systemd.package}/bin/systemctl";
        tailscale = lib.getExe config.services.tailscale.package;
        stateDir = "/run/github-runner-standby";
      in {
        systemd.services =
          lib.genAttrs services (_: {
            # Only the standby timer starts the runners, so they never compete
            # with the primary right after boot.
            wantedBy = lib.mkForce [];
            # An ephemeral runner exits after each job and Restart=on-success
            # brings it back for the next one, so the standby rarely finds it
            # stopped. The flag only exists while the primary is down, and
            # without it the restart is skipped and the unit stays inactive.
            serviceConfig.ExecCondition = "+${pkgs.coreutils}/bin/test -e ${stateDir}/enabled";
          })
          // {
            github-runner-standby = {
              description = "Run the GitHub runners only while ${primary} is down";
              serviceConfig = {
                Type = "oneshot";
                # Keeps the runners' flag and the outage timestamps between
                # runs.
                RuntimeDirectory = "github-runner-standby";
                RuntimeDirectoryPreserve = true;
              };
              scriptArgs = lib.escapeShellArgs services;
              script = ''
                enabled_file=${stateDir}/enabled
                down_since_file=${stateDir}/down-since
                last_round_file=${stateDir}/last-round
                now=$(date +%s)

                # A round long after the previous one means the laptop slept or
                # the timer lagged, so the earlier misses say nothing about now.
                last_round=$(cat "$last_round_file" 2>/dev/null || echo 0)
                echo "$now" >"$last_round_file"
                if ((now - last_round > 300)) && [[ -e $down_since_file ]]; then
                  rm -f "$down_since_file"
                  echo "última rodada há $((now - last_round))s, recomecei a contagem"
                fi

                # Only judge ${primary} while this host is on the tailnet itself,
                # and leave the runners as they are otherwise.
                read -r self_ok primary_online < <(
                  ${tailscale} status --json 2>/dev/null | ${lib.getExe pkgs.jq} -r --arg peer ${primary} '
                    [.BackendState == "Running" and .Self.Online == true,
                     any(.Peer[]?; .HostName == $peer and .Online == true)] | @tsv'
                ) || true
                if [[ $self_ok != true ]]; then
                  rm -f "$down_since_file"
                  echo "${hostName} fora do Tailscale, rodada não conta"
                  exit 0
                fi

                # The coordination server's view comes first: after a network
                # change here it still saw ${primary} while the direct path was
                # broken. The ping only confirms.
                if [[ $primary_online == true ]] || ${tailscale} ping --c 3 --timeout 5s ${primary} >/dev/null 2>&1; then
                  rm -f "$down_since_file" "$enabled_file"
                  for unit in "$@"; do
                    state=$(${systemctl} is-active "$unit" || true)
                    if [[ $state == inactive ]]; then
                      echo "${primary} no ar, $unit já parado"
                    elif [[ $state == failed ]]; then
                      ${systemctl} reset-failed "$unit"
                      echo "${primary} no ar, $unit já parado, limpei o estado failed"
                    # Stopping a runner while it starts or stops interrupts
                    # its registration, e.g. when a switch restarts it.
                    elif [[ $state != active ]]; then
                      echo "${primary} no ar, mantive $unit: $state, tento na próxima rodada"
                    # A job in progress runs as Runner.Worker under the
                    # runner's user. Never kill it: try again next round.
                    elif ${pkgs.procps}/bin/pgrep -u "$unit" -f Runner.Worker >/dev/null; then
                      echo "${primary} no ar, mantive $unit: job em andamento"
                    elif ${systemctl} stop "$unit"; then
                      echo "${primary} no ar, parei $unit"
                    else
                      echo "${primary} no ar, falha ao parar $unit"
                    fi
                  done
                  exit 0
                fi

                # Wait until ${primary} has been down for 10 minutes, so a network
                # change here doesn't bounce the runners.
                [[ -e $down_since_file ]] || echo "$now" >"$down_since_file"
                down_for=$((now - $(cat "$down_since_file")))
                if ((down_for < 600)); then
                  echo "${primary} fora do ar há $((down_for / 60)) min, aguardando 10 min"
                  exit 0
                fi
                touch "$enabled_file"
                for unit in "$@"; do
                  state=$(${systemctl} is-active "$unit" || true)
                  if [[ $state != inactive && $state != failed ]]; then
                    echo "${primary} fora do ar, $unit já no ar"
                  elif ${systemctl} start "$unit"; then
                    echo "${primary} fora do ar, iniciei $unit"
                  else
                    echo "${primary} fora do ar, falha ao iniciar $unit"
                  fi
                done
              '';
            };
          };

        systemd.timers.github-runner-standby = {
          wantedBy = ["timers.target"];
          timerConfig = {
            OnBootSec = "30s";
            OnUnitActiveSec = "2min";
          };
        };
      }))
    ];
}
