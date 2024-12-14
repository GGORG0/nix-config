{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.lmsensors = {
      enable = lib.mkEnableOption "tools for reading hardware sensors";
    };
  };

  config = lib.mkIf config.ggorg.hardware.lmsensors.enable {
    environment.systemPackages = [pkgs.lm_sensors];
  };
}
