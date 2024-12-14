{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hyprland.udiskie = {
      enable = lib.mkEnableOption "udiskie";
    };
  };

  config = {
    services.udiskie = {
      inherit (config.ggorg.hyprland.udiskie) enable;
      tray = "auto";
      notify = true;
      automount = true;
    };
  };
}
