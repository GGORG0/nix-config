{pkgs, ...}:
# System config for Hyprland rice
{
  imports = [
    ./sddm.nix
  ];

  # Enable the Hyprland window manager
  programs.hyprland.enable = true;

  # Hint Electron apps to use Wayland
  environment.sessionVariables."NIXOS_OZONE_WL" = "1";

  # Fix for swaylock with Hyprland
  security.pam.services.swaylock = {};

  # Additional configuration for Blueman
  services.blueman.enable = true;

  # UDisks2 and Gnome Virtual File Systems
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    libnotify # Required for dunst
    qt5.qtwayland # Required for Qt5 on Wayland

    cinnamon.nemo-with-extensions
    gnome.file-roller
    nsxiv
    mpv
  ];
}
