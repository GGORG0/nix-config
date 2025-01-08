{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.keyring = {
      enable = lib.mkEnableOption "Docker";
    };
  };

  config = lib.mkIf config.ggorg.keyring.enable {
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
      # GNOME Keyring
      gcr
      seahorse
      key-rack

      # KDE Wallet
      kdePackages.kwalletmanager
      kdePackages.kwallet
      kdePackages.kwallet-pam
    ];

    security.pam.services = let
      content = {
        enableGnomeKeyring = true;
        kwallet.enable = true;
      };
    in {
      login = content;
      greetd = lib.mkIf config.ggorg.gui.greetd.enable content;
    };
  };
}
