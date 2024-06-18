{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.git = {
      enable = lib.mkEnableOption "Git" // {default = true;};
      user = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "Default user name to use.";
          default = "GGORG";
        };
        email = lib.mkOption {
          type = lib.types.str;
          description = "Default user email to use.";
          default = "GGORG0@protonmail.com";
        };
      };
    };
  };

  config = {
    programs.git = {
      inherit (config.ggorg.git) enable;
      userName = config.ggorg.git.user.name;
      userEmail = config.ggorg.git.user.email;
      aliases = {
        co = "checkout";
        cm = "commit";
        pu = "push";
        pl = "pull";
        st = "status";
      };
    };
  };
}
