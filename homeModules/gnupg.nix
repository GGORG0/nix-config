{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.gnupg = {
      enable = lib.mkEnableOption "GnuPG" // {default = true;};
      publicKeys = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [
          {
            trust = "ultimate";
            source = ./BE009AF8C726EF1A.asc;
          }
        ];
        description = "List of public keys to import";
      };
    };
  };

  config = lib.mkIf config.ggorg.gnupg.enable {
    programs.gpg = {
      enable = true;

      mutableKeys = true;
      mutableTrust = true;

      inherit (config.ggorg.gnupg) publicKeys;
    };
  };
}
