{pkgs, config, ...}: 
  let
    nix-kimo = pkgs.writeShellScriptBin "nix-kimo" ''
      function help() {
        echo "Usage:"
        echo "          nix-kimo [options]"
        echo "Options:"
        echo "          rebuild:        Rebuild NixOS with local config flake"
        echo "          update:         Update local config flake"
        echo "          upgrade:        Push local config flake to Github"
        echo "          gc:             Garbage collect"
        exit 0
      }

      [[ $1 == "" ]] && help

      if [[ $1 == "rebuild" ]];then
        echo "Execute nixos rebuild"
      elif [[ $1 == "update" ]];then
        echo "Execute update"
      elif [[ $1 == "upgrade" ]];then
        echo "Execute upgrade"
      elif [[ $1 == "gc" ]];then
        echo "Execute garbage collection"
      elif [[ $1 == "help" ]];then
        help
      else
        echo "Invalid argument"
      fi
    '';
  in { home.packages = [nix-kimo]; }

