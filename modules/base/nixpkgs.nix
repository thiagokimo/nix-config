{outputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = with outputs.overlays; [
      additions
      modifications
      stable-packages
    ];
  };
}
