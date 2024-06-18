{
  lib,
  config,
  ...
}: {
  options = {
    ggorg.network = {
      enable = lib.mkEnableOption "NetworkManager" // {default = true;};
      firewall = {
        enable = lib.mkEnableOption "system firewall" // {default = false;};
      };
      ssh = {
        enable = lib.mkEnableOption "OpenSSH server" // {default = true;};
      };
    };
  };

  config = {
    networking.networkmanager.enable = config.ggorg.network.enable;
    networking.firewall.enable = config.ggorg.network.firewall.enable;

    # Rootless access
    ggorg.user.extraGroups = [lib.optional config.ggorg.network.enable "networkmanager"];

    services.openssh.enable = config.ggorg.network.ssh.enable;
  };
}
