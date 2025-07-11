{
  pkgs,
  config,
  ...
}: let
  nix-kimo = pkgs.writeShellScriptBin "nk" ''
    function help() {
      echo "NixKimo (nk) - My nix command shortcuts :)"
      echo "Usage:"
      echo "          nk [options]"
      echo "Options:"
      echo "          help:             Displays this message"
      echo "          check:            Check if the local config flake evaluates"
      echo "          gc:               Garbage collect"
      echo "          push:             Push local configs to Github"
      echo "          rebuild-remote:   Rebuild NixOS with remote config flake"
      echo "          rebuild:          Rebuild NixOS with local config flake"
      echo "          rebuild-hm [name] Rebuild home-manager's entry point"
      echo "          update:           Update local config flake"
      echo "          upgrade:          Push local config flake to Github"
      echo "          show:             Show the output attributes of local config flake"
      echo "          fmt:              Execute formatter in local config flake root"
      echo "          search [query]    Search for package in nixpkgs"
      echo " --- "
      exit 0
    }

    [[ $1 == "" ]] && help

    if [[ $1 == "rebuild" ]];then
      echo "Initiating system rebuild..."
      nixos-rebuild switch --flake ${config.var.configDirectory}#${config.var.hostname}
      exit 0
    elif [[ $1 == "rebuild-hm" ]];then
      if [ -z $2 ];then
        echo "Error: Provide the name of the hm's entry point."
        exit 1
      else
        echo "Initiating home manager rebuild..."
        home-manager switch --flake ${config.var.configDirectory}#$2
        exit 0
      fi
    elif [[ $1 == "update" ]];then
      echo "Initiating local config update..."
      nix flake update --flake ${config.var.configDirectory}
      exit 0
    elif [[ $1 == "upgrade" ]];then
      echo "Initiating remote flake upgrade..."
      cd ${config.var.configDirectory} && git add . && git commit -m "Update from nix-kimo" && git push
      nix flake update github:thiagokimo/nix-config
      exit 0
    elif [[ $1 == "gc" ]];then
      echo "Initiating garbage collection..."
      nix-collect-garbage -d
      exit 0
    elif [[ $1 == "check" ]]; then
      echo "Checking local config flake..."
      nix flake check ${config.var.configDirectory}
      exit 0
    elif [[ $1 == "help" ]];then
      help
      exit 0
    elif [[ $1 == "push" ]];then
      echo "Pushing local changes to Github..."
      git -C ${config.var.configDirectory} push origin
      exit 0
    elif [[ $1 == "show" ]];then
      echo "Output attributes of local config flake..."
      nix flake show ${config.var.configDirectory}
      exit 0
    elif [[ $1 == "fmt" ]];then
      echo "Formatting files..."
      nix fmt ${config.var.configDirectory}
      exit 0
    elif [[ $1 == "search" ]];then
      echo "Searching in nixpkgs for $2"
      nix search nixpkgs $2
      exit 0
    else
      echo "Invalid argument"
      exit 0
    fi
  '';
in {home.packages = [nix-kimo];}
