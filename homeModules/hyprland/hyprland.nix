{
  lib,
  config,
  pkgs,
  flake,
  ...
}: {
  imports = [
    flake.inputs.hyprland.homeManagerModules.default
  ];

  options = {
    ggorg.hyprland = {
      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Monitors to configure, in Hyprland format";
      };
    };
  };

  config = lib.mkIf config.ggorg.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      package = flake.inputs.hyprland.packages.${pkgs.system}.hyprland;

      # for service autostart (instead of using exec-once)
      systemd.enable = true;

      settings = let
        mod = "SUPER";
      in {
        monitor =
          config.ggorg.hyprland.monitors
          ++ [",preferred,auto,1"]; # plug and play for random monitors; will place them on the right

        input = {
          kb_layout = "pl";

          follow_mouse = 1;
          mouse_refocus = false;

          touchpad = {
            natural_scroll = true;
            clickfinger_behavior = true;
            drag_lock = true;
            tap-and-drag = true;
          };
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

        gestures = {
          workspace_swipe = true;
          workspace_swipe_create_new = true;
          workspace_swipe_use_r = true;
        };

        misc = {
          disable_hyprland_logo = true; # hyprpaper covers it

          # just in case hypridle breaks... or something
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        workspace =
          builtins.genList (
            x: (let
              monitor = builtins.elemAt config.ggorg.hyprland.monitors (builtins.floor (x / 10));
            in "${toString (x + 1)},monitor:${monitor}")
          )
          ((builtins.length config.ggorg.hyprland.monitors)
            * 10);

        bind =
          [
            # Power/logout
            "${mod} SHIFT SUPERALT, escape, exit,"
            "${mod}, O, exec, ${lib.getExe' pkgs.systemd "loginctl"} lock-session"

            # App shortcuts
            "${mod}, return, exec, ${lib.getExe pkgs.kitty} --single-instance"
            "${mod}, B, exec, ${lib.getExe pkgs.librewolf}"
            "${mod}, G, exec, ${lib.getExe pkgs.nemo-with-extensions}" # TODO: replace nemo with Yazi

            # Rofi
            "${mod}, R, exec, ${lib.getExe config.programs.rofi.finalPackage} -show drun"
            # "${mod}, period, exec, ${lib.getExe config.programs.rofi.finalPackage} -show emoji"
            # "${mod}, C, exec, ${lib.getExe config.programs.rofi.finalPackage} -show calc -no-show-match -no-sort"
            "${mod}, escape, exec, ${lib.getExe config.programs.rofi.finalPackage} -show power-menu"
            "${mod}, V, exec, ${lib.getExe pkgs.clipman} pick -t CUSTOM -T \"${lib.getExe config.programs.rofi.finalPackage} -dmenu -p '   Clipboard '\""

            # Dunst do not disturb toggle
            "${mod}, D, exec, ${lib.getExe' pkgs.dunst "dunstctl"} set-paused toggle"

            # Screenshots
            ", Print, exec, ${lib.getExe pkgs.grimblast} --notify --freeze copysave area"
            "CTRL, Print, exec, ${lib.getExe pkgs.grimblast} --notify copysave screen"

            # Window actions
            "${mod}, Q, killactive,"
            "${mod}, F, togglefloating,"
            "${mod}, P, pseudo," # resize the app freely, but keep it tiled
            "${mod}, T, togglesplit," # toggle split direction
            "${mod}, M, fullscreen, 1" # maximize but keep panel and gaps
            "${mod} SHIFT, M, fullscreen, 0" # fullscreen (no panel or gaps)
            "${mod} ALT, M, fullscreenstate, 0 3" # make the app think it's fullscreen without altering the geometry

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

            # Scroll through workspaces with mod + scroll
            "${mod}, mouse_down, workspace, +1"
            "${mod}, mouse_up, workspace, -1"

            # Scroll through workspaces with mod + ALT + h/l
            "${mod} ALT, L, workspace, +1"
            "${mod} ALT, H, workspace, -1"

            # The special workspace (overlay/scratchpad)
            "${mod}, grave, togglespecialworkspace,"
            "${mod} SHIFT, grave, movetoworkspace, special"
          ]
          ++ (
            # Workspaces on primary monitor
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
          )
          ++ (
            # Workspaces on secondary monitor
            # binds mod + ALT + [SHIFT +] {1..10} to [move to] workspace {11..20}
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "${mod} ALT, ${ws}, workspace, ${toString (x + 11)}"
                  "${mod} ALT SHIFT, ${ws}, movetoworkspace, ${toString (x + 11)}"
                ]
              )
              10)
          );

        # Move/resize windows with mod + LMB/RMB and dragging
        bindm = [
          "${mod}, mouse:272, movewindow"
          "${mod}, mouse:273, resizewindow"
        ];

        binde = [
          # Resize windows with mod + CTRL + vim keys
          "${mod} CTRL, H, resizeactive, -20 0"
          "${mod} CTRL, J, resizeactive, 0 20"
          "${mod} CTRL, K, resizeactive, 0 -20"
          "${mod} CTRL, L, resizeactive, 20 0"
        ];

        # Brightness and volume keys
        bindel = [
          # (e) Repeat when held down, (l) works on the lockscreen
          ", XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set 5%-"
          ", XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set 5%+"

          ", XF86AudioLowerVolume, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume -l 0 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ];
        bindl = [
          ", XF86AudioMute, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          ", XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ", XF86AudioPause, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ", XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
          ", XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
        ];
      };
    };

    # Make Electron apps use Wayland
    home.sessionVariables."NIXOS_OZONE_WL" = "1";

    # Fix Qt5 on Wayland
    home.packages = [pkgs.qt5.qtwayland];

    # # Fix file chooser being inconsistent
    # xdg.portal = {
    #   enable = true;
    #   extraPortals = [
    #     flake.inputs.xdg-desktop-portal-hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    #     pkgs.xdg-desktop-portal-gtk
    #   ];
    #   config.hyprland = {
    #     default = [
    #       "hyprland"
    #       "gtk"
    #     ];
    #     "org.freedesktop.impl.portal.FileChooser" = [
    #       "gtk"
    #     ];
    #   };
    # };
  };
}
