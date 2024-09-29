{ config
, lib
, ...
}: {
  options = {
    ggorg.hardware.bluetooth = {
      enable = lib.mkEnableOption "Bluetooth";
    };
  };

  config = {
    hardware.bluetooth.enable = config.ggorg.hardware.bluetooth.enable;
  };
}
