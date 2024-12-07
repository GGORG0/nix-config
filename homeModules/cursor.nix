{ pkgs
, lib
, config
, ...
}: {
  options = {
    ggorg.catppuccinCursor = {
      enable = lib.mkEnableOption "Catppuccin cursor";
    };
  };

  config =
    let
      cursorName = "catppuccin-mocha-dark-cursors";
      cursorSize = 16;
    in
    {
      home.pointerCursor = lib.mkIf config.ggorg.catppuccinCursor.enable {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = cursorName;
        size = cursorSize;
        gtk.enable = true;
        x11.enable = true;
      };

      wayland.windowManager.hyprland.settings = {
        env = [
          "HYPRCURSOR_THEME,${cursorName}"
          "HYPRCURSOR_SIZE,${builtins.toString cursorSize}"
        ];
      };
    };
}
