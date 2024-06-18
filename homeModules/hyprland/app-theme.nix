{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ggorg.hyprland.appTheme = {
      enable = lib.mkEnableOption "GTK and QT app themes";
    };
  };

  config = lib.mkIf config.ggorg.hyprland.appTheme.enable {
    # TODO: use catppuccin/nix
    home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
    ];

    xdg.configFile = let
      catppuccin-kvantum = pkgs.catppuccin-kvantum.override {
        accent = "Blue";
        variant = "Mocha";
      };
    in {
      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "Catppuccin-Mocha-Blue";
      };
      "Kvantum/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.kvconfig".source = "${catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.kvconfig";
      "Kvantum/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.svg".source = "${catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.svg";
    };

    home.sessionVariables.QT_STYLE_OVERRIDE = "kvantum";

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          size = "standard";
          variant = "mocha";
        };
      };

      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
