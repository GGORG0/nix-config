{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hyprland.kitty = {
      enable = lib.mkEnableOption "Kitty";
    };
  };

  config = {
    programs.kitty = {
      inherit (config.ggorg.hyprland.kitty) enable;
      themeFile = "Catppuccin-Mocha";
      font = {
        name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      settings = {
        background_opacity = "0.75";
        close_on_child_death = true;
        focus_follows_mouse = true;
        strip_trailing_spaces = "smart";
        tab_activity_symbol = "•";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_max_length = 25;
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        window_padding_width = "5";
        touch_scroll_multiplier = 2;
        cursor_trail = 100;
      };
      shellIntegration = {
        mode = "enabled";
        enableZshIntegration = true;
      };
    };
  };
}
