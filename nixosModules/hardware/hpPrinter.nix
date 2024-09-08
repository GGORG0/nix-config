{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.hpPrinter = {
      enable = lib.mkEnableOption "CUPS + SANE + HP driver";
    };
  };

  config = lib.mkIf config.ggorg.hardware.hpPrinter.enable {
    services.printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };

    hardware.sane.enable = true;
    ggorg.user.extraGroups = ["scanner" "lp"];

    hardware.sane.extraBackends = [pkgs.sane-airscan];
    services.udev.packages = [pkgs.sane-airscan];

    environment.systemPackages = with pkgs; [
      skanlite
      xsane
    ];
  };
}
