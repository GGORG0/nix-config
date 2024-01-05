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
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };

    Install.WantedBy = ["hyprland-session.target"];
  };
}
