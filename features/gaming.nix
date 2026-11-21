# Steam with Proton for Windows games, plus tools that make games run and look
# better: GameMode, gamescope and the MangoHud overlay.
{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      # GE-Proton, a Proton build with extra fixes, to pick per game when the
      # stock Proton fails.
      extraCompatPackages = [pkgs.proton-ge-bin];
      # winetricks inside a game's Proton prefix, for games needing extra DLLs.
      protontricks.enable = true;
      # Steam Input (controller remapping) on Wayland.
      extest.enable = true;
      remotePlay.openFirewall = true;
      # Copy installed games between the laptops over the LAN.
      localNetworkGameTransfers.openFirewall = true;
    };

    # Raises a game's priority and the power profile while it runs.
    # Steam launch option: `gamemoderun %command%`.
    programs.gamemode.enable = true;

    # Micro-compositor to run a game at a lower resolution and upscale it with
    # FSR, e.g. `gamescope -w 1280 -h 720 -W 1920 -H 1080 -F fsr -f -- %command%`.
    programs.gamescope.enable = true;
  };

  flake.modules.homeManager.gaming = {
    # FPS, frame time, CPU and GPU overlay, themed by Stylix.
    # Steam launch option: `mangohud %command%`; Shift_R+F12 toggles it.
    programs.mangohud = {
      enable = true;
      settings = {
        fps = true;
        frametime = true;
        frame_timing = true;
        cpu_stats = true;
        cpu_temp = true;
        gpu_stats = true;
        gpu_temp = true;
        ram = true;
        battery = true;
        position = "top-left";
      };
    };
  };
}
