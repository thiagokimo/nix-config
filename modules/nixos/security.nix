{pkgs, ...}: {
  security.pki.certificateFiles = [
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"   
  ];
}
