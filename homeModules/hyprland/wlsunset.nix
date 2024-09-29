{ config
, lib
, ...
}: {
  options = {
    ggorg.hyprland.wlsunset = {
      enable = lib.mkEnableOption "wlsunset";
      systemdTarget = lib.mkOption {
        type = lib.types.str;
        description = "Systemd target to bind to";
        default = "graphical-session.target";
      };
    };
  };

  config = {
    services.wlsunset = {
      inherit (config.ggorg.hyprland.wlsunset) enable;
      inherit (config.ggorg.hyprland.wlsunset) systemdTarget;

      latitude = "51.1";
      longitude = "17.0";
    };
  };
}
