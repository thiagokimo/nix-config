# Unfree packages and this flake's overlays, for both NixOS and Home Manager.
{inputs, ...}: let
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = with inputs.self.overlays; [
      additions
      modifications
      stable-packages
    ];
  };
in {
  flake.modules.nixos.core = {inherit nixpkgs;};
  flake.modules.homeManager.core = {inherit nixpkgs;};
}
