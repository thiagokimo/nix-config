{
  pkgs,
  config,
  ...
}: let
  nix-kimo = pkgs.writeShellScriptBin "nk" ''
    function help() {
      echo "NixKimo (nk)"
      echo "Usage:"
      echo "          nk [options]"
      echo "Options:"
      echo "          help:           Displays this message"
      echo "          check:          Check if the local config flake evaluates"
      echo "          gc:             Garbage collect"
      echo "          push:           Push local configs to Github"
      echo "          rebuild-remote: Rebuild NixOS with remote config flake"
      echo "          rebuild:        Rebuild NixOS with local config flake"
      echo "          update:         Update local config flake"
      echo "          upgrade:        Push local config flake to Github"
      exit 0
    }

    [[ $1 == "" ]] && help

    if [[ $1 == "rebuild" ]];then
      echo "Initiating system rebuild..."
      sudo nixos-rebuild switch --flake ${config.var.configDirectory}#${config.var.hostname}
      exit 0
    elif [[ $1 == "update" ]];then
      echo "Initiating local config update..."
      sudo nix flake update --flake ${config.var.configDirectory}
      exit 0
    elif [[ $1 == "upgrade" ]];then
      echo "Initiating remote flake upgrade..."
      cd ${config.var.configDirectory} && git add . && git commit -m "Update from nix-kimo" && git push
      sudo nix flake update github:thiagokimo/nix-config
      exit 0
    elif [[ $1 == "gc" ]];then
      echo "Initiating garbage collection..."
      nix-collect-garbage -d
      exit 0
    elif [[ $1 == "check" ]]; then
      echo "Checking local config flake..."
      sudo nix flake check ${config.var.configDirectory}
      exit 0
    elif [[ $1 == "help" ]];then
      help
      exit 0
    elif [[ $1 == "push" ]];then
      echo "Pushing local changes to Github..."
      git -C ${config.var.configDirectory} push origin
      exit 0
    else
      echo "Invalid argument"
      exit 0
    fi
  '';
in {home.packages = [nix-kimo];}
