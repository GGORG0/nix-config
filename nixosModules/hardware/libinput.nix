{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hardware.libinput = {
      enable = lib.mkEnableOption "Libinput";
    };
  };

  config = lib.mkIf config.ggorg.hardware.libinput.enable {
    services.libinput.enable = true;
  };
}
