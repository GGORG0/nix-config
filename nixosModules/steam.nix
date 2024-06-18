{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.steam = {
      enable = lib.mkEnableOption "Steam";
    };
  };
  config = lib.mkIf config.ggorg.steam.enable {
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
      protontricks
    ];
  };
}
