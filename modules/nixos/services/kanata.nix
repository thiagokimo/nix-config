{ config, pkgs, ...}:{
  hardware.uinput.enable = true;

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
