{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.syncthing = {
      enable = lib.mkEnableOption "Syncthing";
    };
  };

  config = {
    services.syncthing = {
      inherit (config.ggorg.syncthing) enable;
    };
  };
}
