{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.docker = {
      enable = lib.mkEnableOption "Podman w/Docker compatibility";
    };
  };

  config = lib.mkIf config.ggorg.docker.enable {
    virtualisation.containers.enable = true;

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    ggorg.user.extraGroups = ["podman"];

    environment.systemPackages = [pkgs.distrobox];
  };
}
