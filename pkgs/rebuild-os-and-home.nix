{
  writeShellScriptBin,
  hostName,
  homeName
}: writeShellScriptBin "Rebuild OS and Home" ''
  if [ -z hostName ]; then
    echo "Hostname must be provided"
    echo "Exiting..."
    exit 0
  elif [ -z homeName ]; then
    echo "Homename must be provided"
    echo "Exiting"
    exit 0
  else
    sudo nixos-rebuild switch --flake github:thiagokimo/nix-config#${hostName}
    home-manager switch --flake github:thiagokimo/nix-config#${homeName}
  fi
''
