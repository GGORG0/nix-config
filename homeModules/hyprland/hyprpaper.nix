{
  lib,
  config,
  ...
}: {
  options = {
    ggorg.hyprland.hyprpaper = {
      enable = lib.mkEnableOption "Hyprpaper";
    };
  };

  config = {
    services.hyprpaper = {
      inherit (config.ggorg.hyprland.hyprpaper) enable;

      settings = {
        preload = ["${./wallpaper.png}"];
        wallpaper = [",${./wallpaper.png}"];

        ipc = false;
        splash = true;
        splash_offset = 1.0;
      };
    };
  };
}
