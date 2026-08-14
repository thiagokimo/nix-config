{
  inputs,
  vars,
}: let
  colors = import ./colors.nix;

  builders = import ./builders.nix {
    inherit inputs vars;
    myLib =
      {
        inherit colors;
        inherit (colors) hexToDec hexToRgb ansi reset;
      }
      // builders;
  };
in
  builders
  // {
    inherit colors;
    inherit (colors) hexToDec hexToRgb ansi reset;
  }
