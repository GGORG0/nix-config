{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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
    };
    shellIntegration = {
      mode = "enabled";
      enableZshIntegration = true;
    };
  };
}
