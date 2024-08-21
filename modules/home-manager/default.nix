{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programs
    ./scripts
  ];
}
