{writeShellScriptBin, ...}:
writeShellScriptBin "create-home-folders" ''

  echo "Creating basic home folders if they don't exist..."
  echo ""

  echo "Creating Audio folder..."
  mkdir -p $HOME/Audio
  echo "Creating Documents folder..."
  mkdir -p $HOME/Documents
  echo "Creating Pictures folder..."
  mkdir -p $HOME/Pictures
  echo "Creating Projects folder..."
  mkdir -p $HOME/Projects
  echo "Creating Videos folder..."
  mkdir -p $HOME/Videos

  echo "Done"
''
