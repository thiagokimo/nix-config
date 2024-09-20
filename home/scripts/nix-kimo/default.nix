{pkgs, config, ...}: 
  let
    nix-kimo = pkgs.writeShellScriptBin "nix-kimo" ''
      function help() {
        echo "Usage:"
        echo "          nix-kimo [options]"
        echo "Options:"
        echo "          rebuild:        Rebuild NixOS with local config flake"
        echo "          rebuild-remote: Rebuild NixOS with remote config flake"
        echo "          update:         Update local config flake"
        echo "          upgrade:        Push local config flake to Github"
        echo "          gc:             Garbage collect"
        exit 0
      }

      [[ $1 == "" ]] && help

      if [[ $1 == "rebuild" ]];then
        echo "Initiating system rebuild..."
        sudo nixos-rebuild switch --flake ${config.var.configDirectory}#${config.var.hostname}
        echo "System rebuild completed!"
        exit 0
      elif [[ $1 == "update" ]];then
        echo "Initiating local config update..."
        sudo nix flake update --flake ${config.var.configDirectory}
        echo "Local config update completed!"
        exit 0
      elif [[ $1 == "upgrade" ]];then
        echo "Initiating remote flake upgrade..."
        cd ${config.var.configDirectory} && git add . && git commit -m "Update from nix-kimo" && git push
        sudo nix flake update --flake github:thiagokimo/nix-config
        echo "Remote flake upgrade completed!"
      elif [[ $1 == "gc" ]];then
        echo "Initiating garbage collection..."
        nix-collect-garbage -d
        echo "Garbage collection completed!"
        exit 0
      elif [[ $1 == "help" ]];then
        help
      else
        echo "Invalid argument"
      fi
    '';
  in { home.packages = [nix-kimo]; }

