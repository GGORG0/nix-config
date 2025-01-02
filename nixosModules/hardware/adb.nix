{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hardware.adb = {
      enable = lib.mkEnableOption "Android Debug Bridge";
    };
  };

  config = lib.mkIf config.ggorg.hardware.adb.enable {
    programs.adb.enable = true;
    ggorg.user.extraGroups = ["adbusers"];
  };
}
