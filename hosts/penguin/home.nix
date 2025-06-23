{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/home.nix
    ./variables.nix
    ./nixgl.nix
    ./kitty-desktop-entry.nix
    ./cros-garcon.nix
  ];
  
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };
}
