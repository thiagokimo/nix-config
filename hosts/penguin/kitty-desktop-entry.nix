{pkgs, ...} : {
  pkgs.mkDesktopItem {
    name = "kitty";
    exec = "nixGLMesa ${pkgs.kitty}/bin/kitty";
    desktopName = "Kitty";
    genericName = "Terminal Emulator";
    comment = "Kitty terminal emulator";
    categories = ["System" "TerminalEmulator"];
    keywords = ["terminal" "console" "shell" "command" "prompt"];
    startupNotify = true;
    startupWMClass = "kitty";
  };
}
