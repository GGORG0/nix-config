{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "GNOME Polkit Authentication Agent";
      PartOf = ["hyprland-session.target"];
    };

    Service = {
      ExecStart = "${lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1"}"; # <-- this line
      Restart = "on-failure";
    };

    Install.WantedBy = ["hyprland-session.target"];
  };
}
