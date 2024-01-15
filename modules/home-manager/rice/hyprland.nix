{
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # for service autostart (instead of using exec-once)
    systemd.enable = true;

    settings = let
      mod = "SUPER";
    in {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        ",preferred,auto,1" # plug and play for random monitors; will place them on the right
      ];

      input = {
        kb_layout = "pl";

        follow_mouse = 1;

        touchpad.natural_scroll = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 15;

        border_size = 2;
        "col.active_border" = "rgb(89b4fa) rgb(74c7ec) 45deg";
        "col.inactive_border" = "rgba(6c7086aa)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
          "specialWorkspace, 1, 6, default, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_is_master = true;

      gestures = {
        workspace_swipe = true;
        workspace_swipe_numbered = true;
      };

      misc.disable_hyprland_logo = true; # hyprpaper already covers it

      bind =
        [
          # Power/logout
          "${mod} SHIFT SUPERALT, escape, exit,"
          "${mod}, O, exec, ${lib.getExe pkgs.swaylock-effects}"

          # App shortcuts
          "${mod}, return, exec, ${lib.getExe pkgs.kitty} --single-instance"
          "${mod}, E, exec, ${lib.getExe' pkgs.emacs "emacsclient"} -c -a ''"
          "${mod}, B, exec, ${lib.getExe pkgs.librewolf}"
          "${mod}, G, exec, ${lib.getExe pkgs.cinnamon.nemo-with-extensions}"

          # Rofi
          "${mod}, R, exec, ${lib.getExe config.programs.rofi.finalPackage} -show drun"
          "${mod}, period, exec, ${lib.getExe config.programs.rofi.finalPackage} -show emoji"
          "${mod}, C, exec, ${lib.getExe config.programs.rofi.finalPackage} -show calc -no-show-match -no-sort"
          "${mod}, escape, exec, ${lib.getExe config.programs.rofi.finalPackage} -show power-menu"
          "${mod}, V, exec, ${lib.getExe pkgs.clipman} pick -t CUSTOM -T \"${lib.getExe config.programs.rofi.finalPackage} -dmenu -p '   Clipboard '\""

          # Dunst do not disturb toggle
          "${mod}, D, exec, ${lib.getExe' pkgs.dunst "dunstctl"} set-paused toggle"

          # Screenshots
          ", Print, exec, ${lib.getExe pkgs.grimblast} --notify --cursor --freeze copysave area"
          "CTRL, Print, exec, ${lib.getExe pkgs.grimblast} --notify --cursor copysave screen"

          # Window actions
          "${mod}, Q, killactive,"
          "${mod}, F, togglefloating,"
          "${mod}, P, pseudo," # resize the app freely, but keep it tiled
          "${mod}, T, togglesplit," # toggle split direction
          "${mod}, M, fullscreen, 1" # maximize but keep panel and gaps
          "${mod} SHIFT, M, fullscreen, 0" # fullscreen (no panel or gaps)
          "${mod} ALT, M, fakefullscreen," # make the app think it's fullscreen without altering the geometry

          # Move focus with mod + vim keys
          "${mod}, H, movefocus, l"
          "${mod}, J, movefocus, d"
          "${mod}, K, movefocus, u"
          "${mod}, L, movefocus, r"

          # Move windows with mod + SHIFT + vim keys
          "${mod} SHIFT, H, movewindow, l"
          "${mod} SHIFT, J, movewindow, d"
          "${mod} SHIFT, K, movewindow, u"
          "${mod} SHIFT, L, movewindow, r"

          # Resize windows with mod + CTRL + vim keys
          "${mod} CTRL, H, resizeactive, -10 0"
          "${mod} CTRL, J, resizeactive, 0 10"
          "${mod} CTRL, K, resizeactive, 0 -10"
          "${mod} CTRL, L, resizeactive, 10 0"

          # Scroll through workspaces with mod + scroll
          "${mod}, mouse_down, workspace, e+1"
          "${mod}, mouse_up, workspace, e-1"

          # Scroll through workspaces with mod + ALT + h/l
          "${mod} ALT, L, workspace, +1"
          "${mod} ALT, H, workspace, -1"

          # The special workspace (overlay/scratchpad)
          "${mod}, grave, togglespecialworkspace,"
          "${mod} SHIFT, grave, movetoworkspace, special"
        ]
        ++ (
          # Workspaces
          # binds mod + [SHIFT +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "${mod}, ${ws}, workspace, ${toString (x + 1)}"
                "${mod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );

      # Move/resize windows with mod + LMB/RMB and dragging
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];

      # Brightness and volume keys (we have to use PulseAudio CLI here, because PipeWire doesn't have one :/)
      bindel = [
        # (e) Repeat when held down, (l) works on the lockscreen
        ", XF86MonBrightnessDown, exec, ${lib.getExe pkgs.light} -U 5"
        ", XF86MonBrightnessUp, exec, ${lib.getExe pkgs.light} -A 5"

        ", XF86AudioLowerVolume, exec, ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioRaiseVolume, exec, ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ +5%"
      ];
      bindl = [
        ", XF86AudioMute, exec, ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${lib.getExe' pkgs.pulseaudio "pactl"} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
    };
  };
}
