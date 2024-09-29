{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.hardware.yubikey = {
      enable = lib.mkEnableOption "YubiKey services and utilities";
    };
  };

  config = lib.mkIf config.ggorg.hardware.yubikey.enable {
    ggorg.gnupg.enable = lib.mkDefault true;

    services.pcscd.enable = true;
    hardware.gpgSmartcards.enable = true;

    services.udev.packages = [ pkgs.yubikey-personalization ];

    programs.yubikey-touch-detector.enable = true;

    environment.systemPackages = with pkgs; [
      yubioath-flutter
      yubikey-manager-qt
      yubikey-manager
      yubikey-personalization
      pcsctools
    ];
  };
}
