{ pkgs, ... }: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
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
        "HDMI-A-1,2560x1440@144.00Hz,0x0,1"
        "eDP-1,1920x1080@60,2560x0,1"
      ];
    };
    neovim.enable = true;
    zsh.enable = true;
    cursor.enable = true;
    git.enable = true;
  };
}
