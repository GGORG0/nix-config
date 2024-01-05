{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hardwarePresets;
in {
  options.hardwarePresets = {
    bluetooth = lib.mkEnableOption "enable Bluetooth support";
    wacom = lib.mkEnableOption "enable Wacom graphics tablet driver";
    sound = lib.mkEnableOption "enable Pipewire sound support";
    opengl = lib.mkEnableOption "enable OpenGL support";
    touchpad = lib.mkEnableOption "enable touchpad support via libinput";
    printer = lib.mkEnableOption "enable CUPS printing service and install HP driver";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.bluetooth {
      hardware.bluetooth.enable = true;
    })

    (lib.mkIf cfg.wacom {
      services.xserver.wacom.enable = true;
    })

    (lib.mkIf cfg.sound {
      sound.enable = true;
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    })

    (lib.mkIf cfg.opengl {
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    })

    (lib.mkIf cfg.touchpad {
      services.xserver.libinput.enable = true;
    })

    (lib.mkIf cfg.printer {
      services.printing = {
        enable = true;
        drivers = [pkgs.hplipWithPlugin];
      };
    })
  ];
}
