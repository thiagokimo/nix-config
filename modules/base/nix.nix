{vars, ...}: {
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
      allowed-users = [vars.user.name];
      trusted-users = [vars.user.name];
      experimental-features = "nix-command flakes";
    };
  };
}
