{ config
, lib
, ...
}: {
  options = {
    ggorg.hardware.wacom = {
      enable = lib.mkEnableOption "Wacom driver";
    };
  };

  config = {
    services.xserver.wacom.enable = config.ggorg.hardware.wacom.enable;
  };
}
