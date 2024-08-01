{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      alejandra
      git
      home-manager
      nix
    ];
    name = "my-nix-config-shell";
    shellHook = ''
      echo "Welcome to the playground!"
    '';
  };
}
