{
  config,
  lib,
  pkgs,
  ...
}: {
  services.swayidle = {
    enable = true;
    systemdTarget = (import ./systemd-bp.nix).target;

    timeouts = [
      {
        timeout = 300;
        command = "${lib.getExe pkgs.swaylock-effects} --grace 5";
      }
      {
        timeout = 330;
        command = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
        resumeCommand = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
      }
      {
        timeout = 390;
        command = "systemctl suspend";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${lib.getExe pkgs.swaylock-effects}";
      }
      {
        event = "after-resume";
        command = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
      }
      {
        event = "lock";
        command = "${lib.getExe pkgs.swaylock-effects}";
      }
      {
        event = "unlock";
        command = "pkill -USR1 swaylock";
      }
    ];
  };

  systemd.user.services.swayidle-inhibit = {
    Unit = {
      Description = "Service preventing swayidle from sleeping while any application is outputting or receiving audio";
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.sway-audio-idle-inhibit}";
    };
    Install = {WantedBy = ["hyprland-session.target"];};
  };
}
