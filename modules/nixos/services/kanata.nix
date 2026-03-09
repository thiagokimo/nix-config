{
  config,
  pkgs,
  ...
}: {
  boot.kernelModules = ["uinput"];

  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = {};

  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        extraDefCfg = "process-unmapped-keys yes";

        config = ''
          (defsrc
            caps
          )

          (defalias
            escctrl (tap-hold 100 200 esc lctrl)
          )

          (deflayer base
            @escctrl
          )
        '';
      };
    };
  };
}
