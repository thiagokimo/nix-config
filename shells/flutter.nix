{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  env = {
    CHROME_EXECUTABLE = pkgs.chromedriver + "/bin/chromedriver";
  };
  nativeBuildInputs = with pkgs; [
    flutter
    dart
    jdk11
  ];
  name = "Flutter Dev Environment";
  shellHook = "Welcome to the flutter dev environment shell";
}
