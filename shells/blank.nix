{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  env = {};
  nativeBuildInputs = with pkgs; [];
  name = "";
  shellHook = "";
}
