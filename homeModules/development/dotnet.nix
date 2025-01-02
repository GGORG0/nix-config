{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.dotnet = {
      enable = lib.mkEnableOption "Microsoft .NET 8 SDK";
    };
  };

  config = lib.mkIf config.ggorg.development.dotnet.enable {
    home.packages = with pkgs; [
      dotnet-sdk_8
    ];
  };
}
