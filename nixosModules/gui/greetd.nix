{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.gui.greetd = {
      enable = lib.mkEnableOption "greetd";
      target = lib.mkOption {
        type = lib.types.str;
        description = "The command to launch on login";
      };
    };
  };

  config = {
    services.greetd = {
      inherit (config.ggorg.gui.greetd) enable;
      restart = true;

      settings = {
        default_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} --cmd ${config.ggorg.gui.greetd.target}";
        };
      };
    };

    # this is a life saver.
    # literally no documentation about this anywhere.
    # might be good to write about this...
    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
