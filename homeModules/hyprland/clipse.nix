{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hyprland.clipse = {
      enable = lib.mkEnableOption "clipse";
      systemdTarget = lib.mkOption {
        type = lib.types.str;
        description = "Systemd target to bind to";
        default = "graphical-session.target";
      };
    };
  };

  config = {
    services.clipse = {
      inherit (config.ggorg.hyprland.clipse) enable;
      inherit (config.ggorg.hyprland.clipse) systemdTarget;
      imageDisplay.type = "kitty";

      # https://github.com/savedra1/clipse/blob/0845364012312a852f9909f3910b502ac4af1fca/themes/catppuccin.json
      theme = {
        useCustomTheme = true;
        DimmedDesc = "#a6adc8";
        DimmedTitle = "#a6adc8";
        FilteredMatch = "#f38ba8";
        NormalTitle = "#f38ba8";
        NormalDesc = "#a6e3a1";
        SelectedDesc = "#cba6f7";
        SelectedTitle = "#cba6f7";
        SelectedBorder = "#cba6f7";
        SelectedDescBorder = "#cba6f7";
        TitleFore = "#cdd6f4";
        Titleback = "#1e1e2e";
        StatusMsg = "#b4befe";
        PinIndicatorColor = "#D20F39";
      };
    };

    wayland.windowManager.hyprland.settings = {
      windowrule = map (rule: "${rule}, class:(clipse)") [
        "float"
        "size 622 652"
        "noscreenshare"
        "stayfocused"
      ];

      bind = [
        "${config.ggorg.hyprland.mod}, V, exec, ${lib.getExe config.programs.kitty.package} --class clipse ${lib.getExe config.services.clipse.package}"
      ];
    };
  };
}
