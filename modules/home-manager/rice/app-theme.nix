{
  lib,
  config,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home.packages = with pkgs; [
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha-Blue
  '';

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
}
