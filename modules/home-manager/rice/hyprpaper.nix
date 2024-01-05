{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.hyprpaper];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${./wallpaper.png}
    wallpaper = ,${./wallpaper.png}
    ipc = off
    splash = true
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.hyprpaper}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["hyprland-session.target"];
  };
}
