# AI development tools: Claude Code.
{
  flake.modules.homeManager.ai = {pkgs, ...}: {
    home.packages = [pkgs.claude-code];
  };
}
