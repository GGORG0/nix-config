{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.android = {
      enable = lib.mkEnableOption "Android Studio";
    };
  };

  config = lib.mkIf config.ggorg.development.android.enable {
    environment.systemPackages = with pkgs; [
      android-studio
    ];
  };
}
