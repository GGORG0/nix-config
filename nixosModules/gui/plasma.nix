{ config
, lib
, pkgs
, ...
}: {
  options = {
    ggorg.gui.plasma = {
      enable = lib.mkEnableOption "KDE Plasma";
    };
  };

  config = lib.mkIf config.ggorg.gui.plasma.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    # A little bit of debloating
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa # music player
      kate # text editor
    ];

    environment.systemPackages = with pkgs; [
      maliit-keyboard # on screen keyboard for plasma
    ];

    # Make Electron apps use Wayland
    environment.sessionVariables."NIXOS_OZONE_WL" = "1";
  };
}
