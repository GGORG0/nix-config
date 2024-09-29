{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.development.arduino = {
      enable = lib.mkEnableOption "Arduino IDE";
    };
  };

  config = lib.mkIf config.ggorg.development.arduino.enable {
    ggorg.development.python.enable = true;
    environment.systemPackages = with pkgs; [
      arduino-ide
      python312Packages.pyserial # for ESP32 flashing using esptool

      picocom
    ];
  };
}
