{
  config,
  lib,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 450;
        shrink = "no";

        follow = "mouse";

        progress_bar = true;
        progress_bar_max_width = 430;

        transparency = 25;

        frame_color = "#89B4FA";

        idle_threshold = 120;

        font = "JetBrainsMono Nerd Font 12";
        format = "<small>%a</small>\n<b>%s</b>\n%b";

        alignment = "right";

        word_wrap = "yes";
        ellipsize = "end";

        icon_position = "right";
        min_icon_size = 0;
        max_icon_size = 64;

        history_length = 50;

        browser = "${lib.getExe pkgs.librewolf} -new-tab";

        corner_radius = 20;

        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };

      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };

      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };

      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };
    };
  };
}
