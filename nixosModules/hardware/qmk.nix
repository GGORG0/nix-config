{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.hardware.qmk = {
      enable = lib.mkEnableOption "QMK udev rules and tooling";
    };
  };

  config = lib.mkIf config.ggorg.hardware.qmk.enable {
    hardware.keyboard.qmk.enable = true; # udev rules
    ggorg.user.extraGroups = [ "plugdev" ];
    environment.systemPackages = [ pkgs.qmk ];
  };
}
