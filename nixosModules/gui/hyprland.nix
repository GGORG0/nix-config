{ pkgs
, config
, lib
, ...
}: {
  options = {
    ggorg.gui.hyprland = {
      enable = lib.mkEnableOption "Hyprland";
    };
  };

  config = lib.mkIf config.ggorg.gui.hyprland.enable {
    # Enable the Hyprland window manager
    programs.hyprland = {
      enable = true;
    };

    # Enable the greetd display manager
    ggorg.gui.greetd = {
      enable = lib.mkDefault true;
      target = lib.mkDefault (lib.getExe config.programs.hyprland.package);
    };

    # Add the Hyprlock PAM module
    security.pam.services.hyprlock = { };

    # Additional configuration for Blueman
    services.blueman.enable = true;

    # UDisks2 and Gnome Virtual File Systems
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      nemo-with-extensions # TODO: replace with yazi
      file-roller
      nsxiv # TODO: replace with imv or nomacs
      mpv
    ];
  };
}
