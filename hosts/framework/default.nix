# Framework Laptop 13 (AMD).
{
  vars.hosts.framework.nixos = {
    imports = [
      ./_hardware-configuration.nix
    ];
  };
}
