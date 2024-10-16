{config, ...}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      allowed-users = ["${config.var.username}"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
