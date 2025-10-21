{configVars,...}:{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      allowed-users = ["${username}"];
      trusted-users = ["${username}"];
      experimental-features = "nix-command flakes";
    };
  };
}
