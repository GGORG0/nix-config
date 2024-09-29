{ config
, lib
, ...
}: {
  options = {
    ggorg.hyprland.clipman = {
      enable = lib.mkEnableOption "clipman";
      systemdTarget = lib.mkOption {
        type = lib.types.str;
        description = "Systemd target to bind to";
        default = "graphical-session.target";
      };
    };
  };

  config = {
    services.clipman = {
      inherit (config.ggorg.hyprland.clipman) enable;
      inherit (config.ggorg.hyprland.clipman) systemdTarget;
    };
  };
}
