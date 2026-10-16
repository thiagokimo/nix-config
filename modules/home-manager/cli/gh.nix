{config, ...}: let
  sshKey = "${config.home.homeDirectory}/.ssh/id_ed25519";
in {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      aliases.co = "pr checkout";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."github.com" = {
      user = "git";
      identityFile = sshKey;
      identitiesOnly = true;
    };
  };
}
