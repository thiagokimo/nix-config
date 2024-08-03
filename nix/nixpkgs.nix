{
  outputs,
  ...
}: {
  nixpkgs = {
    # overlays = [
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   outputs.overlays.unstable-packages
    # ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
