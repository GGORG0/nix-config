{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.gui.plasma = {
      enable = lib.mkEnableOption "KDE Plasma";
    };
  };

  config = lib.mkIf config.ggorg.gui.plasma.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      settings.General.InputMethod = "qtvirtualkeyboard";
    };

    services.desktopManager.plasma6.enable = true;

    # A little bit of debloating
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa # music player
      kate # text editor
    ];

    environment.systemPackages = with pkgs; [
      maliit-keyboard # on screen keyboard for plasma
      kdePackages.qtvirtualkeyboard # a different on screen keyboard for plasma AND SDDM
    ];

    # Make Electron apps use Wayland
    environment.sessionVariables."NIXOS_OZONE_WL" = "1";
  };
}
