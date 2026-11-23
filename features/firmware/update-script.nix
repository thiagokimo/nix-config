# firmware-update, a helper around fwupdmgr, and sysup, which brings a host up
# to date: pulls this repository, rebuilds NixOS and Home Manager, then
# installs firmware updates. sysup is a script rather than an alias so it also
# runs over SSH (`ssh -tA t14s sysup`), where zsh aliases don't load.
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

    # --no-reboot-check: -y would otherwise accept fwupd's "restart now?", and
    # t14s waits at the LUKS prompt after a reboot until someone is there.
    sysup = pkgs.writeShellApplication {
      name = "sysup";
      runtimeInputs = [pkgs.git pkgs.nh firmware-update];
      text = ''
        git -C ${vars.user.configDir} pull --ff-only
        nh os switch ${vars.user.configDir}
        nh home switch ${vars.user.configDir}
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
      fwupmgr
      sysup
    ];
  };
}
