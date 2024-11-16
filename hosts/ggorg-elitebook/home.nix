{ pkgs, ... }: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      legcord
      equibop
      element-desktop

      # Gaming
      prismlauncher

      # LibreOffice
      libreoffice-fresh
      hunspell
      hunspellDicts.pl-pl

      # Better calculator
      qalculate-gtk

      # ProtonMail desktop client (official one requires paid account)
      electron-mail

      # Hand-written notes
      rnote

      # Image editing
      gimp
      inkscape

      # Screen mirroring from Android
      scrcpy

      # Music player
      spotube

      # PCB editor
      kicad

      # Drag-and-drop in terminal
      xdragon

      # Local file sharing
      localsend
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;

  # --------------------

  ggorg = {
    hyprland = {
      enable = true;
      monitors = [
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,1920x1080@60,1920x0,1"
      ];
    };
    neovim.enable = true;
    zsh.enable = true;
    bibataCursor.enable = true;
    git.enable = true;
    syncthing.enable = true;
  };
}
