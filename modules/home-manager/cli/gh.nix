{config, ...}: let
  sshKey = "${config.home.homeDirectory}/.ssh/id_ed25519";
in {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
      aliases.co = "pr checkout";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."github.com" = {
      User = "git";
      IdentityFile = sshKey;
      IdentitiesOnly = "yes";
    };
  };
}
