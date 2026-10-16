# Keyboard remapping: Caps Lock and Left Control are Escape on tap and Control
# on hold.
{
  # services.kanata sets up uinput and runs each keyboard as kanata-<name>,
  # with access to the input and uinput groups.
  flake.modules.nixos.kanata = {
    services.kanata = {
      enable = true;
      keyboards = {
        default = {
          extraDefCfg = "process-unmapped-keys yes";

          config = ''
            (defsrc
              caps lctrl
            )

            (defalias
              escctrl (tap-hold 100 200 esc lctrl)
            )

            (deflayer base
              @escctrl @escctrl
            )
          '';
        };
      };
    };
  };
}
