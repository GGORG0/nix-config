{
  lib,
  config,
  ...
}: {
  options = {
    ggorg.network = {
      enable = lib.mkEnableOption "NetworkManager" // {default = true;};
      firewall.enable = lib.mkEnableOption "system firewall" // {default = false;};
      ssh.enable = lib.mkEnableOption "OpenSSH server" // {default = true;};
      avahi.enable = lib.mkEnableOption "Avahi daemon" // {default = true;};
    };
  };

  config = lib.mkIf config.ggorg.network.enable {
    networking.networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
        backend = "iwd";
      };
    };

    services.resolved = {
      enable = true;
      fallbackDns = [
        "1.1.1.1"
        "1.0.0.1"
        "9.9.9.9"
        "8.8.8.8"
      ];
    };

    networking.firewall.enable = config.ggorg.network.firewall.enable;

    # Rootless access
    ggorg.user.extraGroups = ["networkmanager"];

    services.openssh.enable = config.ggorg.network.ssh.enable;

    services.avahi = {
      inherit (config.ggorg.network.avahi) enable;
      nssmdns4 = true;
    };
  };
}
