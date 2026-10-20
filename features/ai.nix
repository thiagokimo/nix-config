# AI development tools.
{
  flake.modules.homeManager.ai = {pkgs, ...}: {
    home.packages = with pkgs; [
      claude-code
      opencode
    ];
  };
}
