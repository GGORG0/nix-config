{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.gui.fonts = {
      enable = lib.mkEnableOption "additional fonts";
    };
  };

  config = lib.mkIf config.ggorg.gui.fonts.enable {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        roboto
        inter
        rubik
        poppins
        ubuntu_font_family
        quicksand

        twemoji-color-font

        corefonts
        vistafonts

        nerd-fonts.jetbrains-mono
      ];
      fontconfig = {
        defaultFonts = {
          monospace = ["JetBrainsMono Nerd Font Mono"];
        };
      };
    };
  };
}
