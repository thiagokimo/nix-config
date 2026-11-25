# firmware-update, a helper around fwupdmgr; sysup, which brings a host up to
# date: pulls this repository, rebuilds NixOS and Home Manager, then installs
# firmware updates; and flakeup, which updates the flake inputs through a PR.
# sysup is a script rather than an alias so it also runs over SSH
# (`ssh -tA t14s sysup`), where zsh aliases don't load.
{config, ...}: let
  inherit (config) vars;
in {
  flake.modules.homeManager.firmware = {pkgs, ...}: let
    firmware-update = pkgs.writeShellScriptBin "firmware-update" ''
      function help() {
        echo "Firmware Update Helper"
        echo "Usage:"
        echo "  firmware-update [options]"
        echo ""
        echo "Options:"
        echo "  -c, --check       Check for available firmware updates without installing"
        echo "  -h, --help        Show this help message"
        echo "  -y, --assume-yes  Install updates without prompting for confirmation"
        echo ""
        echo "Any additional options will be passed directly to fwupdmgr."
        exit 0
      }

      if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        help
      fi

      if [[ "$1" == "-c" || "$1" == "--check" ]]; then
        echo "Refreshing firmware metadata..."
        ${pkgs.fwupd}/bin/fwupdmgr refresh || true
        echo ""
        echo "Checking for firmware updates..."
        if ${pkgs.fwupd}/bin/fwupdmgr get-updates; then
          exit 0
        else
          exit_code=$?
          if [ $exit_code -eq 2 ]; then
            echo "No firmware updates available."
            exit 0
          fi
          exit $exit_code
        fi
      fi

      echo "Refreshing firmware metadata..."
      ${pkgs.fwupd}/bin/fwupdmgr refresh || true

      echo ""
      echo "Checking for firmware updates..."
      if ${pkgs.fwupd}/bin/fwupdmgr get-updates; then
        echo ""
        echo "Updates available! Installing firmware updates..."
        ${pkgs.fwupd}/bin/fwupdmgr update "$@"
      else
        exit_code=$?
        if [ $exit_code -eq 2 ]; then
          echo "No firmware updates available."
          exit 0
        else
          echo "Error checking for firmware updates (exit code: $exit_code)."
          exit $exit_code
        fi
      fi
    '';

    # Updates flake.lock on a branch and opens a PR for it, after the same
    # checks as CI and a build of this host. The lock is shared by every host,
    # so it changes in one place and reaches the others through git; each host
    # updating its own lock would leave them on different inputs.
    flakeup = pkgs.writeShellApplication {
      name = "flakeup";
      runtimeInputs = [pkgs.coreutils pkgs.gh pkgs.git pkgs.gnugrep pkgs.nh];
      text = ''
        cd ${vars.user.configDir}

        if [ "$(git branch --show-current)" != main ]; then
          echo "flakeup: switch ${vars.user.configDir} to main first" >&2
          exit 1
        fi
        if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
          echo "flakeup: ${vars.user.configDir} has uncommitted changes" >&2
          exit 1
        fi
        git pull --ff-only

        # Without a token nix asks GitHub's API anonymously, which allows 60
        # requests an hour; an update and a build use them up and get 403s.
        # gh's token raises that to 5000, for this script's nix commands only:
        # it isn't written to nix.conf or the store.
        if token=$(gh auth token 2>/dev/null); then
          NIX_CONFIG=$(printf '%s\naccess-tokens = github.com=%s' "''${NIX_CONFIG:-}" "$token")
          export NIX_CONFIG
        else
          echo "flakeup: gh isn't logged in, so GitHub may refuse with 403 (rate limit)" >&2
        fi

        log=$(mktemp)
        trap 'rm -f "$log"' EXIT
        nix flake update 2>&1 | tee "$log"
        if git diff --quiet flake.lock; then
          echo "flakeup: every input is already up to date"
          exit 0
        fi
        changes=$(grep -A2 "Updated input" "$log" || true)

        if ! nix flake check --no-build || ! nh os build .; then
          echo "flakeup: the update doesn't build; 'git restore flake.lock' drops it" >&2
          exit 1
        fi

        branch="flake-update-$(date +%F)"
        git switch --create "$branch"
        git commit --quiet --message "Updates flake" flake.lock

        read -r -p "Push $branch and open a PR? [y/N] " answer
        if [ "$answer" = y ] || [ "$answer" = Y ]; then
          git push --set-upstream origin "$branch"
          # The backticks are Markdown for the PR, not command substitution.
          # shellcheck disable=SC2016
          body=$(printf 'Inputs updated by `nix flake update`:\n\n```\n%s\n```\n\n`nix flake check --no-build` passes, and %s builds with it.\n' "$changes" "$(hostname)")
          gh pr create --base main --head "$branch" --title "Updates flake" --body "$body"
        else
          echo "Not pushed; the commit stays on $branch."
        fi
        echo "This checkout stays on $branch, so sysup here switches to the update."
        echo "After the PR is merged: git switch main, then sysup on every host."
      '';
    };

    # Brings this host up to the branch it's on, normally main. --update first
    # runs flakeup, so this host switches to the new lock while its PR is open.
    # --no-reboot-check: -y would otherwise accept fwupd's "restart now?", and
    # t14s waits at the LUKS prompt after a reboot until someone is there.
    sysup = pkgs.writeShellApplication {
      name = "sysup";
      runtimeInputs = [pkgs.git pkgs.nh firmware-update flakeup];
      text = ''
        case "''${1:-}" in
          "") update=false ;;
          --update) update=true ;;
          *)
            echo "usage: sysup [--update]" >&2
            exit 2
            ;;
        esac

        cd ${vars.user.configDir}
        if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
          echo "sysup: ${vars.user.configDir} has uncommitted changes" >&2
          exit 1
        fi

        if $update; then
          flakeup
        fi
        # A branch flakeup didn't push has nothing to pull from.
        if git rev-parse --abbrev-ref '@{upstream}' > /dev/null 2>&1; then
          git pull --ff-only
        fi
        nh os switch .
        nh home switch .
        firmware-update -y --no-reboot-check
      '';
    };

    fwupmgr = pkgs.writeShellScriptBin "fwupmgr" ''
      exec ${pkgs.fwupd}/bin/fwupdmgr "$@"
    '';
  in {
    home.packages = [
      pkgs.fwupd
      firmware-update
      flakeup
      fwupmgr
      sysup
    ];
  };
}
