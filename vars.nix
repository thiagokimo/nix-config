let
  username = "thiago";
in {
  username = username;
  stateVersion = "25.11";
  email = "kimo@kimo.io";
  path = "/home/${username}/.config/nix-config";
  editor = "nvim";
  browser = "google-chrome-stable";
}
