{ config
, lib
, ...
}: {
  options = {
    ggorg.hardware.sound = {
      enable = lib.mkEnableOption "PipeWire";
    };
  };

  config = lib.mkIf config.ggorg.hardware.sound.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
