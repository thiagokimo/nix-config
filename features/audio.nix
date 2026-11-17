# Sound through PipeWire: the NixOS side runs the audio stack, the Home Manager
# side adds the mixers that control it.
{
  flake.modules.nixos.audio = {pkgs, ...}: {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pipewire.jack # provides pw-jack to run JACK clients against PipeWire
      pulseaudio # provides pactl for PulseAudio/PipeWire card & sink management
    ];
  };

  flake.modules.homeManager.audio = {pkgs, ...}: {
    home.packages = with pkgs; [
      wiremix # audio management
      pavucontrol # audio controller
    ];
  };
}
