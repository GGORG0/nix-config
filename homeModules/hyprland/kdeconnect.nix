{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hyprland.kdeconnect = {
      enable = lib.mkEnableOption "KDE Connect";
    };
  };

  config = {
    services.kdeconnect = lib.mkIf config.ggorg.hyprland.kdeconnect.enable {
      # TODO: fix all the issues with KDE Connect (theming, remote control, clipboard and URL sharing)
      enable = true;
      indicator = true;
    };
  };
}
