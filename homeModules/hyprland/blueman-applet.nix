{ config
, lib
, ...
}: {
  options = {
    ggorg.hyprland.bluemanApplet = {
      enable = lib.mkEnableOption "Blueman tray applet";
    };
  };

  config = {
    services.blueman-applet.enable = config.ggorg.hyprland.bluemanApplet.enable;
  };
}
