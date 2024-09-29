{ pkgs
, config
, lib
, ...
}: {
  options = {
    ggorg.hyprland.polkit = {
      enable = lib.mkEnableOption "GNOME Polkit";
      systemdTarget = lib.mkOption {
        type = lib.types.str;
        description = "Systemd target to bind to";
        default = "graphical-session.target";
      };
    };
  };

  config = {
    systemd.user.services.polkit-gnome-authentication-agent-1 = lib.mkIf config.ggorg.hyprland.polkit.enable {
      Unit = {
        Description = "GNOME Polkit Authentication Agent";
        PartOf = [ config.ggorg.hyprland.polkit.systemdTarget ];
      };

      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
