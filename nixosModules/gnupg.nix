{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.gnupg = {
      enable = lib.mkEnableOption "GnuPG + dirmngr + gpg-agent";
    };
  };

  config = lib.mkIf config.ggorg.gnupg.enable {
    programs.gnupg = {
      agent = {
        enable = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
      dirmngr.enable = true;
    };
  };
}
