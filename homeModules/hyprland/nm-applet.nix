{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hyprland.nmApplet = {
      enable = lib.mkEnableOption "NetworkManager tray applet";
    };
  };

  config = {
    services.network-manager-applet.enable = config.ggorg.hyprland.nmApplet.enable;
  };
}
