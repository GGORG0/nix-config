{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.hpPrinter = {
      enable = lib.mkEnableOption "CUPS + HP driver";
    };
  };

  config = lib.mkIf config.ggorg.hardware.hpPrinter.enable {
    services.printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
  };
}
