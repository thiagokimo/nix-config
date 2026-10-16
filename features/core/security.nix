# Trusted certificate authorities.
{
  flake.modules.nixos.core = {pkgs, ...}: {
    security.pki.certificateFiles = [
      "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    ];
  };
}
