{...}: {
  imports = [
    ./app-theme.nix
    ./dunst.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./kdeconnect.nix
    ./kitty.nix
    ./polkit.nix
    ./rofi.nix
    ./swayidle.nix
    ./swaylock.nix
    ./udiskie.nix
    ./waybar.nix
    ./wlsunset.nix
  ];

  services = {
    clipman = let
      systemd = import ./systemd-bp.nix;
    in {
      inherit (systemd) enable;
      systemdTarget = systemd.target;
    };
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
