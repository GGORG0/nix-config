{ config
, lib
, ...
}: {
  options = {
    ggorg.tailscale = {
      enable = lib.mkEnableOption "Tailscale";
    };
  };

  config = {
    services.tailscale.enable = config.ggorg.tailscale.enable;
  };
}
