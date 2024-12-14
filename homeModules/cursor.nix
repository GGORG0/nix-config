{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ggorg.cursor = {
      enable = lib.mkEnableOption "Catppuccin cursor";

      name = lib.mkOption {
        type = lib.types.str;
        description = "The name of the cursor theme";
        default = "Bibata-Modern-Classic";
      };

      size = lib.mkOption {
        type = lib.types.int;
        description = "The size of the cursor";
        default = 16;
      };

      package = lib.mkOption {
        type = lib.types.package;
        description = "The package with the cursor theme";
        default = pkgs.bibata-cursors;
      };

      hyprcursor = lib.mkEnableOption "Hyprcursor" // {default = false;};
    };
  };

  config = lib.mkIf config.ggorg.cursor.enable {
    home.packages = [
      config.ggorg.cursor.package
    ];

    home.pointerCursor = {
      inherit (config.ggorg.cursor) package name size;
      gtk.enable = true;
      x11.enable = true;
    };

    xdg.dataFile."icons/${config.ggorg.cursor.name}".source = "${config.ggorg.cursor.package}/share/icons/${config.ggorg.cursor.name}";

    wayland.windowManager.hyprland.settings = lib.mkIf config.ggorg.cursor.hyprcursor {
      env = [
        "HYPRCURSOR_THEME,${config.ggorg.cursor.name}"
        "HYPRCURSOR_SIZE,${builtins.toString config.ggorg.cursor.size}"
      ];
      exec-once = [
        "hyprctl setcursor ${config.ggorg.cursor.name} ${toString config.ggorg.cursor.size}"
      ];
    };

    home.sessionVariables = lib.mkIf config.ggorg.cursor.hyprcursor {
      HYPRCURSOR_THEME = config.ggorg.cursor.name;
      HYPRCURSOR_SIZE = builtins.toString config.ggorg.cursor.size;
    };
  };
}
