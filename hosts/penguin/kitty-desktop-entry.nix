{pkgs, ...}: {
  home.file.".local/share/applications/kitty.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Version=1.0
    Name=Kitty
    GenericName=Terminal Emulator
    Comment=Fast, feature-rich, cross-platform terminal emulator
    Icon=kitty
    TryExec=${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa ${pkgs.kitty}/bin/kitty
    Exec=${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa ${pkgs.kitty}/bin/kitty
    Terminal=false
    Categories=System;TerminalEmulator;
    Keywords=terminal;console;shell;command;prompt;
    StartupNotify=true
    StartupWMClass=kitty
  '';
}
