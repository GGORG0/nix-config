{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hardware.power = {
      enable = lib.mkEnableOption "Power management";
    };
  };

  config = lib.mkIf config.ggorg.hardware.power.enable {
    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
