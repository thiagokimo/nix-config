{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
    ];
    env = {
      NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    };
    shellHook = ''
      echo "Welcome back, Thiago :)"
    '';
  };
}
