{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.platformio = {
      enable = lib.mkEnableOption "PlatformIO";
    };
  };

  config = lib.mkIf config.ggorg.hardware.platformio.enable {
    environment.systemPackages = [pkgs.platformio-core];
    services.udev.packages = [pkgs.platformio-core.udev];
  };
}
