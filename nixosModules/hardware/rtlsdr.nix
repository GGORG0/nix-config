{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.rtlsdr = {
      enable = lib.mkEnableOption "RTL-SDR";
    };
  };

  config = lib.mkIf config.ggorg.hardware.rtlsdr.enable {
    hardware.rtl-sdr.enable = true;
    environment.systemPackages = [pkgs.sdrpp];
  };
}
