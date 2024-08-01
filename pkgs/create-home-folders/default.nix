{
  writeShellScriptBin,
  ...
} : writeShellScriptBin "create-home-folders" ''

  echo "Creating basic home folders if they don't exist..."
  echo ""

  echo "Creating Audio folder..."
  mkdir -p Audio
  echo "Creating Documents folder..."
  mkdir -p Documents
  echo "Creating Pictures folder..."
  mkdir -p Pictures
  echo "Creating Projects folder..."
  mkdir -p Projects
  echo "Creating Videos folder..."
  mkdir -p Videos

  echo "Done"
''
