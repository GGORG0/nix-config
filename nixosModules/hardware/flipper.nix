{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hardware.flipper = {
      enable = lib.mkEnableOption "Flipper Zero";
    };
  };

  config = {
    hardware.flipperzero.enable = config.ggorg.hardware.flipper.enable;
  };
}
