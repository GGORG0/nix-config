{
  config,
  lib,
  pkgs,
  ...
}: {
  services.udiskie = {
    enable = true;
    tray = "auto";
    notify = true;
    automount = true;
  };
}
