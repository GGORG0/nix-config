{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.em7455 = {
      enable = lib.mkEnableOption "FCC unlocking for the Sierra Wireless EM7455 modem";
    };
  };

  config = lib.mkIf config.ggorg.hardware.em7455.enable {
    networking.networkmanager.fccUnlockScripts = [
      rec {
        id = "1199:9079";
        path = "${pkgs.modemmanager}/share/ModemManager/fcc-unlock.available.d/${id}";
      }
    ];
  };
}
