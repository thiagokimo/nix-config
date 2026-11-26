{inputs, ...}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
