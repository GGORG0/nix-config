{
  lib,
  config,
  ...
}: {
  imports = [
    ./apps.nix
    ./app-theme.nix
    ./blueman-applet.nix
    ./clipse.nix
    ./dunst.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kdeconnect.nix
    ./kitty.nix
    ./nm-applet.nix
    ./polkit.nix
    ./rofi.nix
    ./udiskie.nix
    ./waybar.nix
    ./wlsunset.nix
  ];

  options = {
    ggorg.hyprland.enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf config.ggorg.hyprland.enable {
    # Enable other components
    ggorg.hyprland = {
      apps.defaultEnable = lib.mkDefault true;
      appTheme.enable = lib.mkDefault true;
      bluemanApplet.enable = lib.mkDefault true;
      clipse.enable = lib.mkDefault true;
      dunst.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault true;
      hyprpaper.enable = lib.mkDefault true;
      kdeconnect.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
      nmApplet.enable = lib.mkDefault true;
      polkit.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
      udiskie.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
      wlsunset.enable = lib.mkDefault true;
    };
  };
}
