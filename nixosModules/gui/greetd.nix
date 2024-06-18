{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.gui.greetd = {
      enable = lib.mkEnableOption "greetd";
      target = lib.mkOption {
        type = lib.types.str;
        description = "The command to launch on login";
      };
    };
  };

  config = {
    services.greetd = {
      inherit (config.ggorg.gui.greetd) enable;
      restart = true;

      settings = {
        default_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} --cmd ${config.ggorg.gui.greetd.target}";
        };
      };
    };
  };
}
