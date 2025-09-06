{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    ggorg.hyprland.waybar = {
      enable = lib.mkEnableOption "Waybar";
      systemdTarget = lib.mkOption {
        type = lib.types.str;
        description = "Systemd target to bind to";
        default = "graphical-session.target";
      };
    };
  };

  config = {
    programs.waybar = {
      inherit (config.ggorg.hyprland.waybar) enable;

      systemd = {
        enable = config.ggorg.hyprland.waybar.systemdTarget != "";
        target = config.ggorg.hyprland.waybar.systemdTarget;
      };

      settings = [
        {
          layer = "top";
          position = "top";

          # --- LEFT MODULES ---
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];

          "hyprland/workspaces" = {
            sort-by-name = true;
            format = "{id}";
            show-special = true;
            move-to-monitor = true;
            on-scroll-up = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e+1";
            on-scroll-down = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e-1";
          };

          "hyprland/window" = {
            icon = true;
            icon-size = 16;
            separate-outputs = true;
          };

          # --- CENTER MODULES ---
          modules-center = [
            "clock"
          ];

          clock = {
            interval = 1;
            format = "{:L%H:%M:%S %a %d %b}";
            timezone = "Europe/Warsaw";
            locale = "pl_PL.UTF-8";
            tooltip-format = "<tt>{calendar}</tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };

          # --- RIGHT MODULES ---
          modules-right = [
            "wireplumber"
            "cpu"
            "memory"
            "disk"
            "backlight"
            "battery"
            "power-profiles-daemon"
            "custom/dunst"
            "privacy"
            "idle_inhibitor"
            "tray"
          ];

          wireplumber = {
            format = "{volume}% {icon} {format_source}";
            format-muted = " {format_source}";

            format-source = "{volume}% ";
            format-source-muted = "";

            format-icons = ["" "" ""];

            on-click = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = lib.getExe pkgs.pwvucontrol;
            on-click-middle = lib.getExe pkgs.helvum;
          };

          cpu = {
            interval = 2;
            format = "{usage}% ";
          };

          memory = {
            interval = 2;
            format = "{percentage}% ";
          };

          disk = {
            path = "/";
            format = "{percentage_used}% ";
            tooltip-format = "{free} free of {total}";
          };

          backlight = {
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          battery = {
            interval = 10;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}% ";
            format-icons = ["󱃍" "󱃍" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹"];
            tooltip-format = "{capacity}%\n{timeTo}\n{power} W";
          };

          power-profiles-daemon = {
            format = "{icon} ";
            format-icons = {
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          "custom/dunst" = {
            exec =
              lib.getExe'
              (pkgs.writeShellScriptBin "dunst" ''
                set -euo pipefail

                ENABLED=""
                DISABLED=""
                DISABLED_UNREAD=""

                ${lib.getExe' pkgs.dbus "dbus-monitor"} path='/org/freedesktop/Notifications',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged' --profile |
                    while read -r _; do
                        PAUSED="$(${lib.getExe' pkgs.dunst "dunstctl"} is-paused)"
                        if [ "$PAUSED" == 'false' ]; then
                            TEXT="$ENABLED"
                        else
                            TEXT="$DISABLED"
                            COUNT="$(${lib.getExe' pkgs.dunst "dunstctl"} count waiting)"
                            if [ "$COUNT" != '0' ]; then
                                TEXT="$COUNT $DISABLED_UNREAD"
                            fi
                        fi
                        printf '{"text": "%s"}\n' "$TEXT"
                    done
              '') "dunst";
            return-type = "json";
            on-click = "${lib.getExe' pkgs.dunst "dunstctl"} set-paused toggle";
          };

          privacy = {
            icon-spacing = 10;
            icon-size = 16;
            modules = map (type: {
              inherit type;
              tooltip = true;
              tooltip-icon-size = 18;
            }) ["screenshare" "audio-out" "audio-in"];
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          tray = {
            spacing = 10;
            icon-size = 16;
          };
        }
      ];

      # TODO: move the colors to catppuccin/nix
      style = ''
        /*
        * Catppuccin Mocha palette
        * Maintainer: rubyowo
        */

        @define-color base   #1e1e2e;
        @define-color mantle #181825;
        @define-color crust  #11111b;

        @define-color text     #cdd6f4;
        @define-color subtext0 #a6adc8;
        @define-color subtext1 #bac2de;

        @define-color surface0 #313244;
        @define-color surface1 #45475a;
        @define-color surface2 #585b70;

        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;

        @define-color blue      #89b4fa;
        @define-color lavender  #b4befe;
        @define-color sapphire  #74c7ec;
        @define-color sky       #89dceb;
        @define-color teal      #94e2d5;
        @define-color green     #a6e3a1;
        @define-color yellow    #f9e2af;
        @define-color peach     #fab387;
        @define-color maroon    #eba0ac;
        @define-color red       #f38ba8;
        @define-color mauve     #cba6f7;
        @define-color pink      #f5c2e7;
        @define-color flamingo  #f2cdcd;
        @define-color rosewater #f5e0dc;

        /* --- GENERAL --- */
        * {
          font-family: 'JetBrainsMono Nerd Font Propo';
          font-size: 14px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: @text;
        }

        tooltip {
          background-color: @surface0;
          border: 1px solid @overlay0;
        }

        tooltip label {
          color: @text;
        }

        .modules-left,
        .modules-center,
        .modules-right {
          background-color: @surface0;
          border-radius: 10px;
          margin: 10px 10px 0 10px;
          padding: .1rem;
        }

        .module {
          margin: 0 .5rem;
        }

        /* --- LEFT MODULES --- */

        #workspaces {
          background-color: @surface0;
        }

        #workspaces button {
          color: @lavender;
          background-color: transparent;
          border-radius: 10px;
          padding: 0.25rem;
          margin: 0.3rem 0;

          transition: color 0.5s, background-color 0.5s;
        }

        #workspaces button.empty {
          color: @overlay0;
        }

        #workspaces button.special {
          color: @rosewater;
        }

        #workspaces button.active {
          color: @sky;
          background-color: @surface1;
        }

        #workspaces button.urgent {
          color: @red;
        }

        #workspaces button:hover {
          color: @sapphire;
          background-color: @surface2;
        }

        #window {
          background-color: @surface0;
        }

        /* see https://github.com/Alexays/Waybar/wiki/Module:-Sway#style-1 */
        window#waybar.empty #window {
          margin: 0;
          padding: 0;
          background: none;
        }

        /* --- CENTER MODULES --- */

        #clock {
          color: @blue;
        }

        /* --- RIGHT MODULES --- */

        #pulseaudio {
          color: @lavender;
        }

        #cpu {
          color: @blue;
        }

        #memory {
          color: @sapphire;
        }

        #disk {
          color: @sky;
        }

        #backlight {
          color: @teal;
        }

        #battery {
          color: @green;
        }

        #power-profiles-daemon {
          color: @yellow;
        }

        #custom-dunst {
          color: @peach;
        }

        #privacy {
          color: @maroon;
          padding: 0 .25rem;
        }

        #idle_inhibitor {
          color: @red;
        }
      '';
    };
  };
}
