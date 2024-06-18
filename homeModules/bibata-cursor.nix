{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ggorg.bibataCursor = {
      enable = lib.mkEnableOption "Bibata cursor";
    };
  };

  config = {
    home.pointerCursor = lib.mkIf config.ggorg.bibataCursor.enable {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
