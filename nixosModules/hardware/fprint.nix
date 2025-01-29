{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hardware.fprint = {
      enable = lib.mkEnableOption "Fprint fingerprint daemon";
    };
  };

  config = {
    services.fprintd.enable = config.ggorg.hardware.fprint.enable;

    # Hyprlock will handle it itself
    security.pam.services.hyprlock.fprintAuth = false;
  };
}
