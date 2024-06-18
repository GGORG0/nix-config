{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.gui.gnome = {
      enable = lib.mkEnableOption "GNOME";
      gdm.enable = lib.mkEnableOption "GNOME Display Manager";
    };
  };

  config = lib.mkIf config.ggorg.gui.gnome.enable {
    ggorg.gui.gnome.gdm.enable = lib.mkDefault true; # Enable GDM by default if GNOME is enabled

    services.xserver.displayManager.gdm.enable = config.ggorg.gui.gnome.gdm.enable;
    services.xserver.desktopManager.gnome.enable = true;

    # Remove GNOME bloatware
    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-tour
        snapshot
      ])
      ++ (with pkgs.gnome; [
        cheese
        epiphany
        geary
        simple-scan
        gnome-logs
        gnome-maps
        gnome-weather
      ]);

    environment.systemPackages =
      (with pkgs; [
        qt5.qtwayland # Required for Qt5 on Wayland
        gnome.gnome-tweaks
      ])
      ++ (with pkgs.gnomeExtensions; [
        # GNOME Extensions
        appindicator
        gsconnect
        always-show-titles-in-overview
        hibernate-status-button
        alphabetical-app-grid
      ]);

    # Fix AppIndicators
    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    # Make Electron apps use Wayland
    environment.sessionVariables."NIXOS_OZONE_WL" = "1";
  };
}
