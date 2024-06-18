{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.locale = {
      timeZone = lib.mkOption {
        type = lib.types.str;
        description = "The system time zone";
        default = "Europe/Warsaw";
      };
      defaultLocale = lib.mkOption {
        type = lib.types.str;
        description = "The system's default locale";
        default = "en_US.UTF-8";
      };
      extraLocale = lib.mkOption {
        type = lib.types.str;
        description = "The system's extra locale";
        default = "pl_PL.UTF-8";
      };

      keymap = {
        x11 = lib.mkOption {
          type = lib.types.str;
          description = "The keyboard layout used by X11";
          default = "pl";
        };
        console = lib.mkOption {
          type = lib.types.str;
          description = "The keyboard layout used by the TTY";
          default = "pl2";
        };
      };
    };
  };

  config = {
    # Set the time zone
    time.timeZone = config.ggorg.locale.timeZone;

    # Select internationalisation properties
    i18n.defaultLocale = config.ggorg.locale.defaultLocale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.ggorg.locale.extraLocale;
      LC_IDENTIFICATION = config.ggorg.locale.extraLocale;
      LC_MEASUREMENT = config.ggorg.locale.extraLocale;
      LC_MONETARY = config.ggorg.locale.extraLocale;
      LC_NAME = config.ggorg.locale.extraLocale;
      LC_NUMERIC = config.ggorg.locale.defaultLocale; # hate those commas instead of periods
      LC_PAPER = config.ggorg.locale.extraLocale;
      LC_TELEPHONE = config.ggorg.locale.extraLocale;
      LC_TIME = config.ggorg.locale.extraLocale;
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = config.ggorg.locale.keymap.x11;
      variant = "";
    };

    # Configure console keymap
    console.keyMap = config.ggorg.locale.keymap.console;
  };
}
