{ lib
, config
, ...
}: {
  options = {
    ggorg.network = {
      enable = lib.mkEnableOption "NetworkManager" // { default = true; };
      firewall = {
        enable = lib.mkEnableOption "system firewall" // { default = false; };
      };
      ssh = {
        enable = lib.mkEnableOption "OpenSSH server" // { default = true; };
      };
    };
  };

  config = lib.mkIf config.ggorg.network.enable {
    networking.networkmanager.enable = true;
    networking.firewall.enable = config.ggorg.network.firewall.enable;

    # Rootless access
    ggorg.user.extraGroups = [ "networkmanager" ];

    services.openssh.enable = config.ggorg.network.ssh.enable;
  };
}
