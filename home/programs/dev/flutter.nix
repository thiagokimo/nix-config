{
  pkgs,
  ...
}: {
  
  home = {
    packages = with pkgs; [
      flutter
      dart
      jdk11
    ];
    sessionVariables = {
      CHROME_EXECUTABLE = pkgs.chromedriver + "/bin/chromedriver";
      FLUTTER_ROOT = pkgs.flutter;
      DART_ROOT = "${pkgs.flutter}/bin/cache/dart-sdk";
      JAVA_HOME = pkgs.jdk11.home;
    };
  };
}
