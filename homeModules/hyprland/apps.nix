{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    ggorg.hyprland.apps = {
      defaultEnable = lib.mkEnableOption "Enable all apps";

      nemo = lib.mkEnableOption "Nemo file explorer" // {default = config.ggorg.hyprland.apps.defaultEnable;};
      fileRoller = lib.mkEnableOption "File Roller archive manager" // {default = config.ggorg.hyprland.apps.defaultEnable;};
      nomacs = lib.mkEnableOption "Nomacs image viewer" // {default = config.ggorg.hyprland.apps.defaultEnable;};
      vlc = lib.mkEnableOption "VLC media player" // {default = config.ggorg.hyprland.apps.defaultEnable;};
    };
  };

  config = let
    cfg = config.ggorg.hyprland.apps;
    optionalPkg = pkg: enable: (lib.optionals enable [pkg]);
  in {
    home.packages = lib.mkMerge (with pkgs; [
      (optionalPkg nemo-with-extensions cfg.nemo)
      (optionalPkg file-roller cfg.fileRoller)
      (optionalPkg nomacs-qt6 cfg.nomacs)
      (optionalPkg vlc cfg.vlc)
    ]);

    xdg = {
      mime.enable = true;
      mimeApps = rec {
        enable = true;
        defaultApplications = {
          "inode/directory" = ["nemo.desktop"];
          "application/x-archive" = ["org.gnome.FileRoller.desktop"];
          "application/zip" = ["org.gnome.FileRoller.desktop"];
          "image/*" = ["org.nomacs.ImageLounge.desktop"];
          "video/*" = ["vlc.desktop"];

          "application/pdf" = ["librewolf.desktop"];
        };
        associations.added = defaultApplications;
      };
    };
  };
}
