{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.docker = {
      enable = lib.mkEnableOption "Docker";
    };
  };

  config = lib.mkIf config.ggorg.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };

    ggorg.user.extraGroups = ["docker"];
  };
}
