{
  lib,
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # The XDG portal
  xdg.portal.enable = true;

  # System fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf

      corefonts
      vistafonts

      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };
}
