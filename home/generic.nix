{ lib, ...}: {
  imports = [./base];
  home.persistence = lib.mkForce {};
}
