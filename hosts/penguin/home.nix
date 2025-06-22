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
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };
}
