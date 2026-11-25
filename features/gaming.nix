# Steam with Proton for Windows games, plus tools that make games run and look
# better: GameMode, gamescope and the MangoHud overlay. GeForce NOW streams
# games from NVIDIA's servers; it only ships as a Flatpak.
{inputs, ...}: {
  flake.modules.nixos.gaming = {
    config,
    lib,
    pkgs,
    ...
  }: let
    # The power profile from before the game, restored when it ends.
    saved = ''"$XDG_RUNTIME_DIR/gamemode-power-profile"'';

    performanceProfile = pkgs.writeShellApplication {
      name = "gamemode-performance-profile";
      runtimeInputs = [pkgs.power-profiles-daemon];
      text = ''
        powerprofilesctl get > ${saved}
        powerprofilesctl set performance
      '';
    };

    restoreProfile = pkgs.writeShellApplication {
      name = "gamemode-restore-profile";
      runtimeInputs = [pkgs.coreutils pkgs.power-profiles-daemon];
      text = ''
        if [ -f ${saved} ]; then
          powerprofilesctl set "$(cat ${saved})"
          rm -f ${saved}
        fi
      '';
    };
  in {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

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

    # GameMode only changes the CPU governor. The power profile (in
    # power-saver, the firmware caps the power the CPU and the integrated GPU
    # share) goes to performance while a game runs, and back to the previous
    # one after the last game ends.
    programs.gamemode.settings.custom = lib.mkIf config.services.power-profiles-daemon.enable {
      start = lib.getExe performanceProfile;
      end = lib.getExe restoreProfile;
    };

    # Micro-compositor to run a game at a lower resolution and upscale it with
    # FSR, e.g. `gamescope -w 1280 -h 720 -W 1920 -H 1080 -F fsr -f -- %command%`.
    programs.gamescope.enable = true;

    # GeForce NOW from NVIDIA's own Flatpak repository. Its runtime comes from
    # Flathub, so that default remote stays.
    services.flatpak = {
      enable = true;
      remotes = lib.mkOptionDefault [
        {
          name = "GeForceNOW";
          location = "https://international.download.nvidia.com/GFNLinux/flatpak/geforcenow.flatpakrepo";
        }
      ];
      packages = [
        {
          appId = "com.nvidia.geforcenow";
          origin = "GeForceNOW";
        }
      ];
      update.auto.enable = true;
    };

    # Flatpak requires the system portal service. The Hyprland session still
    # uses the portals Home Manager sets up (features/hyprland/portal.nix),
    # since it points xdg-desktop-portal at them.
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      # Any portal found, as before xdg-desktop-portal 1.17, where a session
      # doesn't choose; the user's config, read first, chooses in Hyprland.
      config.common.default = "*";
    };
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
