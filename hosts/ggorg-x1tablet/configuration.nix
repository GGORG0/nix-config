{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/nix-conf.nix # Nix package manager configuration
    ../../modules/nixos/locale.nix # Timezone + locale

    ../../modules/nixos/systemd-boot.nix # The systemd-boot bootloader
    ../../modules/nixos/hardware.nix # Hardware configuration
    ../../modules/nixos/network.nix # NetworkManager & firewall

    ../../modules/nixos/user.nix # The main user account
    ../../modules/nixos/common-pkgs.nix # My frequently used command-line tools
    ../../modules/nixos/gui.nix # Common GUI, fonts and sound configuration

    ../../modules/nixos/development.nix # Development & compilation tools
  ];

  # LUKS encryption
  boot.initrd.luks.devices."luks-97201d96-c267-4dd0-be74-006d78e0ec1f".device = "/dev/disk/by-uuid/97201d96-c267-4dd0-be74-006d78e0ec1f";

  # Hostname
  networking.hostName = "ggorg-x1tablet";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
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
      gnome.gnome-tweaks # The classic :)
    ])
    ++ (with pkgs.gnomeExtensions; [
      # GNOME Extensions
      appindicator
      gsconnect
      improved-osk
      always-show-titles-in-overview
      hibernate-status-button
      alphabetical-app-grid
      custom-hot-corners-extended
    ]);

  # Fix GNOME stuff ig (for appindicator)
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

  # OpenSSH daemon TODO: move to module
  services.openssh.enable = true;

  # Enable options from hardware.nix (not to be confused with hardware-configuration.nix!)
  hardwarePresets = {
    bluetooth = true;
    wacom = true;
    sound = true;
    opengl = true;
    touchpad = true;
    printer = true;
  };

  # Hardware sensors like accelerometer
  hardware.sensor.iio.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="60a3", ATTR{power/wakeup}="disabled"
  '';

  # Misc
  environment.sessionVariables."NIXOS_OZONE_WL" = "1";

  virtualisation.waydroid.enable = true;
}
