{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.flutter = {
      enable = lib.mkEnableOption "Flutter";
    };
  };

  config = lib.mkIf config.ggorg.development.flutter.enable (lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        flutter
      ];
    }

    # (lib.mkIf config.ggorg.development.android.enable {
    #   environment.systemPackages = with pkgs; [
    #     jdk17
    #   ];
    # })
  ]);
}
