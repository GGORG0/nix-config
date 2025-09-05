{
  lib,
  config,
  ...
}: {
  options = {
    ggorg.hyprland.hyprlock = {
      enable = lib.mkEnableOption "Hyprlock";
    };
  };

  config = {
    programs.hyprlock = let
      text = "rgb(cdd6f4)";
      accent = "rgb(89b4fa)";
      accentAlpha = "89b4fa";
      font = "JetBrainsMono Nerd Font Mono";
    in {
      inherit (config.ggorg.hyprland.hyprlock) enable;

      settings = {
        general = {
          grace = 3;
          ignore_empty_input = true;
        };

        auth.fingerprint.enabled = true;

        background = [
          {
            monitor = "";
            path = "screenshot";

            blur_passes = 2;
            blur_size = 5;
          }
        ];

        label = [
          {
            monitor = "";
            position = "0, 150";
            halign = "center";
            valign = "center";

            # clock
            text = "$TIME";

            color = text;
            shadow_passes = 1;
            shadow_boost = 2;

            font_size = 90;
            font_family = font;
          }
          {
            monitor = "";
            position = "0, 75";
            halign = "center";
            valign = "center";

            # date
            text = "cmd[update:10000] echo \"$(date +\"%A, %d %B %Y\")\"";

            color = text;
            shadow_passes = 1;
            shadow_boost = 2;

            font_size = 25;
            font_family = font;
          }
          {
            monitor = "";
            position = "-20, -20";
            halign = "right";
            valign = "top";

            # battery
            text = "cmd[update:10000] echo \"󰁾 $(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status | cut -c 1)\"";

            color = text;
            shadow_passes = 1;
            shadow_boost = 2;

            font_size = 15;
            font_family = font;
          }
          {
            monitor = "";
            position = "0, -75";
            halign = "center";
            valign = "center";

            # fingerprint prompt
            text = "$FPRINTPROMPT";

            color = text;
            shadow_passes = 1;
            shadow_boost = 2;

            font_size = 15;
            font_family = font;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "300, 60";
            position = "0, 0";
            halign = "center";
            valign = "center";

            outline_thickness = 4;

            dots_size = 0.33;
            dots_spacing = 0.2;
            dots_center = true;

            outer_color = accent;
            inner_color = "rgb(313244)";
            font_color = text;

            fade_on_empty = false;
            placeholder_text = ''<span foreground="##cdd6f4">󰌾 Logged in as <span foreground="##${accentAlpha}">$USER</span></span>'';

            hide_input = false;

            check_color = accent;
            fail_color = "rgb(f38ba8)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            capslock_color = "rgb(f9e2af)";
          }
        ];
      };
    };
  };
}
