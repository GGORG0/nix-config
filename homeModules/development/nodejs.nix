{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.nodejs = {
      enable = lib.mkEnableOption "NodeJS";
    };
  };

  config = lib.mkIf config.ggorg.development.nodejs.enable {
    home.packages = with pkgs; [
      nodejs
      yarn-berry
      pnpm
    ];
  };
}
