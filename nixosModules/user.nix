{
  pkgs,
  lib,
  config,
  ...
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
        default = [];
      };
      sudo = lib.mkEnableOption "wheel group for the default user" // {default = true;};
      shell = lib.mkOption {
        type = lib.types.nullOr (lib.types.either lib.types.shellPackage (lib.types.passwdEntry lib.types.path));
        description = "The default user's login shell";
        default = pkgs.zsh;
      };
      authorizedKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Authorized SSH keys for the default user.";
        default = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCabxl9olbXU/XRM3t4Xv2ToebLzN9PpEbOsW8G/xKdr0bH27ekjHfvyUc5tdP4ktr5Yb8LrD43CX7kgk5PGXnaHsQEpWmJaksoUHydk9Mhg8uext9TYF4q55nP1aBgdRfGvV3k2f3qTbN3pMoKeYjk+beyFHPXX7ZmVyNkRWN6rkuBAoR3XBZ76n+gvsHZhgJM95tm2AKY/EvTd2q8mfJoWgZNjKT+2w3z/T7IBV+rtQXwYyVQCdADXieXDvvcGrRP4sY/jvu0VLO1Osw/2fKm/bbfWsdMZD2mpTFz7F2pxqQzSceH6JNcAgDgJ03JATS3mbE/GIeKNrIpKQ3c5vwTsnCG9NA1zGQJv2syRlNaqGd8oOMcKUKMWrdp3vMBR07km5rkWVin1RMrGwXgQTpTC4uGCLq3BRZ31BSN5F+3gE0hSL011H+Yr6eAZsyutievWtAHY2mSEJzcozwe1abPcxGwtLi6M9d0ITFivoRn74rL9sOB2g43D5BhX8tftgZsfKRDG81o1YieHTTXZIB24DulOFPfOt8rO8zOevW/Tw9sIRyVMMwNjr1BlYoawfCbvdbUye7d+XVZPlo7AaZx5sU48HFOFxxVDu1f6ODwTwPZWqa3re482RsL38parr9cCooYkv8WS/sGOJk3T+3dXALjoEiJA4qjmBaXGqvSZw== yubikey"
        ];
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
        ++ lib.optionals config.ggorg.user.sudo ["wheel"]
        ++ config.ggorg.user.extraGroups;
      inherit (config.ggorg.user) shell;
      openssh.authorizedKeys.keys = config.ggorg.user.authorizedKeys;
    };
    nix.settings.trusted-users = [config.ggorg.user.username];
    security.sudo.extraConfig = ''
      Defaults lecture = never
      Defaults pwfeedback
      Defaults timestamp_timeout = 300
      Defaults passprompt = "[31m[ sudo] password for %p:[0m "
    '';
  };
}
