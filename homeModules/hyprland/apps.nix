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
        defaultApplications = let
          imageTypes = [
            "avif"
            "bmp"
            "gif"
            "heic"
            "heif"
            "jpeg"
            "jxl"
            "png"
            "tiff"
            "webp"
            "x-eps"
            "x-ico"
            "x-portable-bitmap"
            "x-portable-graymap"
            "x-portable-pixmap"
            "x-xbitmap"
            "x-xpixmap"
          ];
          imageMimeTypes = map (t: "image/" + t) imageTypes;
          imageApps = lib.genAttrs imageMimeTypes (_: ["org.nomacs.ImageLounge.desktop"]);
        in
          imageApps
          // {
            "inode/directory" = ["nemo.desktop"];
            "application/x-archive" = ["org.gnome.FileRoller.desktop"];
            "application/zip" = ["org.gnome.FileRoller.desktop"];
            "application/pdf" = ["librewolf.desktop"];
            "x-scheme-handler/terminal" = ["kitty.desktop"];
          };
        associations.added = defaultApplications;
      };
    };
  };
}
