{ lib
, config
, ...
}: {
  options = {
    ggorg.boot = {
      systemd-boot = {
        enable = lib.mkEnableOption "systemd-boot" // { default = true; };
        timeout = lib.mkOption {
          type = lib.types.int;
          description = "Timeout (in seconds) until loader boots the default menu item";
          default = 1;
        };
      };
      sysrq = lib.mkOption {
        type = lib.types.int;
        description = "Sets the value of kernel.sysrq";
        default = 383; # prohibits force reboot (alt+sysrq+b)
      };
    };
  };

  config = {
    boot.loader = {
      inherit (config.ggorg.boot.systemd-boot) timeout;
      systemd-boot = lib.mkIf config.ggorg.boot.systemd-boot.enable {
        enable = true;
        configurationLimit = 5;

        # Very cool that NixOS has those built-in!
        memtest86.enable = true;
        netbootxyz.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    # enables the SysRq key in case of system freezes
    boot.kernel.sysctl."kernel.sysrq" = config.ggorg.boot.sysrq;
  };
}
