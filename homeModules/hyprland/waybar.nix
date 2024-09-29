{ lib
, pkgs
, config
, ...
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
            persistent-workspaces = { "*" = 10; };
            on-scroll-up = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e+1";
            on-scroll-down = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e-1";
          };

          # --- CENTER MODULES ---
          modules-center = [
            "clock"
          ];

          clock = {
            interval = 1;
            format = " {:%H:%M:%S %d %b}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
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
            "pulseaudio"
            "cpu"
            "memory"
            "backlight"
            "battery"
            "custom/dunst"
            "custom/audio_idle_inhibitor"
            "idle_inhibitor"
            "tray"
          ];

          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-muted = " {format_source}";

            format-bluetooth = "{volume}% {icon}  {format_source}";
            format-bluetooth-muted = "   {format_source}";

            format-source = "{volume}% ";
            format-source-muted = "";

            format-icons = [ "" "" "" ];

            on-click = "${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = lib.getExe pkgs.pavucontrol;
            on-click-middle = lib.getExe pkgs.helvum;
          };

          cpu = {
            interval = 10;
            format = "{usage}% ";
          };

          memory = {
            interval = 10;
            format = "{percentage}% ";
          };

          backlight = {
            format = "{percent}% {icon}";
            format-icons = [ "" "" "" "" "" "" "" "" "" ];
          };

          battery = {
            interval = 30;
            full-at = 95;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}% ";
            format-icons = [ "󱃍" "󱃍" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹" ];
            tooltip-format = "{capacity}%\n{timeTo}\n{power} W";
          };

          "custom/dunst" = {
            exec =
              lib.getExe'
                (pkgs.writeShellScriptBin "dunst" ''
                  set -euo pipefail

                  ENABLED=
                  DISABLED=
                  DISABLED_UNREAD=

                  ${lib.getExe' pkgs.dbus "dbus-monitor"} path='/org/freedesktop/Notifications',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged' --profile |
                      while read -r _; do
                          PAUSED="$(${lib.getExe' pkgs.dunst "dunstctl"} is-paused)"
                          if [ "$PAUSED" == 'false' ]; then
                              TEXT="$ENABLED "
                          else
                              TEXT="$DISABLED "
                              COUNT="$(${lib.getExe' pkgs.dunst "dunstctl"} count waiting)"
                              if [ "$COUNT" != '0' ]; then
                                  TEXT="$COUNT $DISABLED_UNREAD "
                              fi
                          fi
                          printf '{"text": "%s"}\n' "$TEXT"
                      done
                '') "dunst";
            return-type = "json";
            on-click = "${lib.getExe' pkgs.dunst "dunstctl"} set-paused toggle";
          };

          "custom/audio_idle_inhibitor" = {
            format = "{icon}";
            exec = "${lib.getExe pkgs.sway-audio-idle-inhibit} --dry-print-both-waybar";
            return-type = "json";
            format-icons = {
              output = "";
              input = "";
              output-input = "  ";
              none = "";
            };
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };

          tray.spacing = 10;
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
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: @text;
        }

        #window,
        #clock,
        #pulseaudio,
        #cpu,
        #memory,
        #backlight,
        #battery,
        #custom-dunst,
        #custom-audio_idle_inhibitor,
        #idle_inhibitor,
        #tray {
          background-color: @surface0;
          padding: 0.5rem 0.75rem;
          margin: 5px 0;
        }

        /* --- LEFT MODULES --- */

        #workspaces {
          border-radius: 1rem 0px 0px 1rem;

          margin: 5px 0 5px 5px;
          padding-left: 0.3rem;
          background-color: @surface0;
        }

        #workspaces button {
          color: @lavender;
          background-color: transparent;
          border-radius: 2rem;
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

        #workspaces button:hover {
          color: @sapphire;
          background-color: @surface2;
        }

        #window {
          border-radius: 0px 1rem 1rem 0px;
          background-color: @surface0;
          margin-right: 1rem;
        }

        /* --- CENTER MODULES --- */

        #clock {
          border-radius: 1rem;
          color: @blue;
        }

        /* --- RIGHT MODULES --- */

        #pulseaudio {
          color: @blue;
          border-radius: 1rem 0px 0px 1rem;
          margin-left: 1rem;
        }

        #cpu {
          color: @lavender;
        }

        #memory {
          color: @sapphire;
        }

        #backlight {
          color: @green;
        }

        #battery {
          color: @yellow;
        }

        #battery.warning:not(.charging) {
          color: @red;
        }

        #custom-dunst {
          color: @peach;
        }

        #custom-audio_idle_inhibitor {
          color: @maroon;
        }

        #idle_inhibitor {
          margin-right: 0.75rem;
          border-radius: 0px 1rem 1rem 0px;
        }

        #idle_inhibitor.deactivated {
          color: @red;
        }

        #idle_inhibitor.activated {
          color: @green;
        }

        /*---*/

        #tray {
          margin-right: 0.75rem;
          border-radius: 1rem;
          margin: 5px 5px 5px 0;
        }
      '';
    };
  };
}
