{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
    ];
    name = "my-nix-config-shell";
    shellHook = ''
      echo "Welcome to the playground!"
    '';
  };
}
