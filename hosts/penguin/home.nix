{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/home.nix
    ./variables.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
