{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.discord.enable = lib.mkEnableOption "Discord";
  };

  config = {
    home.packages = lib.mkIf config.ggorg.discord.enable [
      pkgs.legcord
    ];
  };
}
