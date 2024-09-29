{ pkgs
, lib
, config
, ...
}: {
  options = {
    ggorg.user = {
      username = lib.mkOption {
        type = lib.types.passwdEntry lib.types.str;
        description = "The default user's username";
        default = "ggorg";
      };
      description = lib.mkOption {
        type = lib.types.passwdEntry lib.types.str;
        description = "The default user's description";
        default = "GGORG";
      };
      extraGroups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "The default user's groups";
        default = [ ];
      };
      sudo = lib.mkEnableOption "wheel group for the default user" // { default = true; };
      shell = lib.mkOption {
        type = lib.types.nullOr (lib.types.either lib.types.shellPackage (lib.types.passwdEntry lib.types.path));
        description = "The default user's login shell";
        default = pkgs.zsh;
      };
    };
  };

  config = {
    # Define the default user (add more manually)
    users.users.${config.ggorg.user.username} = {
      isNormalUser = true;
      inherit (config.ggorg.user) description;
      extraGroups =
        [
          "video" # backlight control
          "dialout" # USB to serial adapters (ex. arduino)
        ]
        ++ lib.optionals config.ggorg.user.sudo [ "wheel" ]
        ++ config.ggorg.user.extraGroups;
      inherit (config.ggorg.user) shell;
    };
    nix.settings.trusted-users = [ config.ggorg.user.username ];
  };
}
