{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.hardware.saleae = {
      enable = lib.mkEnableOption "Udev rules and PulseView software for Saleae logic analzers";
    };
  };

  config = lib.mkIf config.ggorg.hardware.saleae.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0925", ATTRS{idProduct}=="3881", MODE="0666"
    '';

    environment.systemPackages = with pkgs; [
      pulseview
    ];
  };
}
