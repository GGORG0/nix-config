{ config
, lib
, ...
}: {
  options = {
    ggorg.hardware.iioSensors = {
      enable = lib.mkEnableOption "support for IIO based sensors";
    };
  };

  config = lib.mkIf config.ggorg.hardware.iioSensors.enable {
    hardware.sensor.iio.enable = true;
  };
}
