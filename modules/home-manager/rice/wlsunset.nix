_: {
  services.wlsunset = {
    enable = true;
    systemdTarget = (import ./systemd-bp.nix).target;

    latitude = "51.1";
    longitude = "17.0";
  };
}
