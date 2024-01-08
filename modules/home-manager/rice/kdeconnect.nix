{
  config,
  lib,
  pkgs,
  ...
}: {
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
