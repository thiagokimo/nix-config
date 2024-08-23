{pkgs ? import <nixpkgs> {}, ...}: {
  nix = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      alejandra
      git
      home-manager
      nix
    ];
    name = "My default Nix dev shell";
    shellHook = ''
      echo "Welcome to the playground!"
    '';
  };
}
