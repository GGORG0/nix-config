{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
  ];

  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-sddm-corners";
  };
}
