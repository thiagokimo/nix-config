{inputs, ...}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    openldap = prev.openldap.overrideAttrs (oldAttrs: {
      doCheck = false;
      doInstallCheck = false;
    });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
