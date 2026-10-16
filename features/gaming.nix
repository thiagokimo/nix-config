# Steam, and Wine for Windows games outside Steam.
{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      wineWow64Packages.stable
      winetricks
      zenity
    ];
  };
}
