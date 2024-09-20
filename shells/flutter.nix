{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  env = {
    CHROME_EXECUTABLE = pkgs.chromedriver + "/bin/chromedriver";
    FLUTTER_ROOT = pkgs.flutter;
    JAVA_HOME = pkgs.jdk11.home;
    DART_ROOT = "${pkgs.flutter}/bin/cache/dart-sdk";
  };
  nativeBuildInputs = with pkgs; [
    flutter
    dart
    jdk11
  ];
  name = "Flutter Dev Environment";
  shellHook = "Welcome to the flutter dev environment shell";
}
