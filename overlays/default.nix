{ inputs, ... }: {
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    # TODO Add an overlay for Steam
    # steamOverlay = prev.steam.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
