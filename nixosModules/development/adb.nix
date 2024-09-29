{ config
, lib
, ...
}: {
  options = {
    ggorg.development.adb = {
      enable = lib.mkEnableOption "Android Debug Bridge";
    };
  };

  config = lib.mkIf config.ggorg.development.adb.enable {
    programs.adb.enable = true;
    ggorg.user.extraGroups = [ "adbusers" ];
  };
}
