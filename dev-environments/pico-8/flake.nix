{
  description = "Pico-8 executable";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: flake-utils.lib.eachDefaultSystem(system: let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    fhs = pkgs.buildFHSUserEnv {
      name = "pico8";
      targetPkgs = pkgs: (with pkgs; [
        xorg.libX11
        xorg.libXext
        xorg.libXcursor
        xorg.libXinerama
        xorg.libXi
        xorg.libXrandr
        xorg.libXScrnSaver
        xorg.libXxf86vm
        xorg.libxcb
        xorg.libXrender
        xorg.libXfixes
        xorg.libXau
        xorg.libXdmcp
        alsa-lib
        udev
        wget
      ]);
      runScript = "bash -c ./pico8";
    };

  in {
    formatter = pkgs.alejandra;
    devShells.default = fhs.env;
  }); 

}
