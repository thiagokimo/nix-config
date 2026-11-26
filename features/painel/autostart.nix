# Opens painel in kitty on the first workspace when Hyprland starts, so it's
# the first thing on screen after logging in.
#
# This adds a second hyprland.start handler to hyprland.lua, after the one in
# features/hyprland/hyprland.nix: Hyprland runs every handler, in the order
# they were added. It only fires at startup, so reloading the config doesn't
# open another painel.
{
  flake.modules.homeManager.painel = {
    config,
    lib,
    pkgs,
    ...
  }: {
    xdg.configFile."hypr/hyprland.lua".text = lib.mkIf config.wayland.windowManager.hyprland.enable (lib.mkAfter ''

      -- painel on the first workspace, see features/painel/autostart.nix
      hl.on("hyprland.start", function()
        hl.exec_cmd("[workspace 1] ${pkgs.kitty}/bin/kitty --class painel -e ${lib.getExe config.programs.painel.package}")
      end)
    '');
  };
}
