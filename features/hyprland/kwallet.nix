# KWallet, for Noctalia's kwallet-secrets plugin: it answers NetworkManager's
# Wi-Fi and VPN password requests from the wallet instead of prompting.
{
  flake.modules.nixos.hyprland = {pkgs, ...}: {
    # The wallet opens at login when it shares the login password. greetd's PAM
    # file only includes login, so rules set on greetd itself are ignored.
    # tuigreet starts the session from a TTY, which the module would skip.
    security.pam.services.login.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
      forceRun = true;
    };

    # kwalletd6 starts on demand from the session bus.
    services.dbus.packages = [pkgs.kdePackages.kwallet];
  };

  flake.modules.homeManager.hyprland = {pkgs, ...}: {
    home.packages = [
      pkgs.kdePackages.kwallet
      pkgs.kdePackages.kwalletmanager
      # The plugin's helper runs as python3 from the PATH.
      (pkgs.python3.withPackages (ps: [ps.dbus-python ps.pygobject3]))
    ];

    programs.noctalia.settings.plugins.enabled = ["grassyloki/kwallet-secrets"];
  };
}
