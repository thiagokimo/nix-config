{
  description = "Flutter dev environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flutter-nix.url = "github:maximoffua/flutter.nix/stable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flutter-nix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          flutter-nix.overlays.default
        ];
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
      androidEnv = pkgs.androidenv.override {licenseAccepted = true;};
      androidComposition = androidEnv.composeAndroidPackages {
        cmdLineToolsVersion = "8.0";
        platformVersions = ["34"];
        buildToolsVersions = ["34.0.0"];
        includeNDK = false;
        extraLicenses = ["android-sdk-license"];
      };
      androidSdk = androidComposition.androidsdk;
    in {
      formatter = pkgs.alejandra;
      packages.flutter = flutter-nix.packages.${system}.flutter;
      devShells.default = with pkgs;
        mkShell rec {
          env = {
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            CHROME_EXECUTABLE = "${pkgs.ungoogled-chromium}/bin/chromium";
          };
          buildInputs = [
            vscode
            flutter
            jdk11
            ungoogled-chromium
            firebase-tools
          ];
          shellHook = ''
            if [ -z "$PUB_CACHE" ]; then
              export PATH="$PATH:$HOME/.pub-cache/bin"
            else
              export PATH="$PATH:$PUB_CACHE/bin"
            fi
            flutter --version
          '';
        };
    });
}
