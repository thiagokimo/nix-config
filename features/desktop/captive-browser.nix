# captive-browser: a separate Chrome that resolves names through the DNS server
# the Wi-Fi's DHCP handed out, bypassing Tailscale's MagicDNS, so captive
# portals (hotels, malls, airports) can load. Run `captive-browser`. Each laptop
# sets programs.captive-browser.interface to its Wi-Fi interface.
{
  flake.modules.nixos.desktop = {
    lib,
    pkgs,
    ...
  }: {
    programs.captive-browser = {
      enable = true;
      # Chrome is already installed, so on a captive network there's no
      # Chromium to download.
      browser = lib.concatStringsSep " " [
        ''env XDG_CONFIG_HOME="$PREV_CONFIG_HOME"''
        "${pkgs.google-chrome}/bin/google-chrome-stable"
        "--user-data-dir=\${XDG_DATA_HOME:-$HOME/.local/share}/chrome-captive"
        ''--proxy-server="socks5://$PROXY"''
        ''--proxy-bypass-list="<-loopback>"''
        "--no-first-run"
        "--new-window"
        "--incognito"
        "--no-default-browser-check"
        "--disable-extensions"
        "--disable-sync"
        "--disable-background-networking"
        "http://neverssl.com/"
      ];
    };
  };
}
