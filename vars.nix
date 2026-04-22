let
  username = "thiago";
in {
  username = username;
  stateVersion = "26.05";
  email = "kimo@kimo.io";
  path = "/home/${username}/.config/nix-config";
  editor = "nvim";
  browser = "google-chrome-stable";
}
