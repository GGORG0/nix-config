{ lib
, pkgs
, config
, ...
}: {
  options = {
    ggorg.hyprland.hypridle = {
      enable = lib.mkEnableOption "Hypridle";
    };
  };

  config = {
    services.hypridle = {
      inherit (config.ggorg.hyprland.hypridle) enable;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || ${lib.getExe config.programs.hyprlock.package} --immediate";
          unlock_cmd = "pkill -USR1 hyprlock";

          before_sleep_cmd = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
          after_sleep_cmd = "${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "pidof hyprlock || ${lib.getExe config.programs.hyprlock.package}";
          }
          {
            timeout = 330;
            on-timeout = "${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms off";
            on-resume = "${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
          }
          {
            timeout = 600;
            on-timeout = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
          }
        ];
      };
    };
  };
}
