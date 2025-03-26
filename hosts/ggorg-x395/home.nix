{pkgs, ...}: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      element-desktop
      fractal

      # Gaming
      prismlauncher

      # LibreOffice
      libreoffice-fresh
      hunspell
      hunspellDicts.pl-pl
      hunspellDicts.en-us

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
      kicad-small

      # Drag-and-drop in terminal
      xdragon

      # Local file sharing
      localsend
      warp

      # Useful for debugging and reverse engineering
      httptoolkit
      mitmproxy

      # Merge, slice, rearrange PDF pages
      pdfslicer

      # You know what this is, right?
      osu-lazer-bin

      # Doing stuff with audio and video
      ffmpeg-full

      # Audio editor
      tenacity
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;

  # --------------------

  ggorg = {
    development = {
      android.enable = true;
      arduino.enable = true;
      dotnet.enable = true;
      gcc.enable = true;
      nodejs.enable = true;
      python.enable = true;
      rust.enable = true;
    };
    hyprland = {
      enable = true;
      monitors = [
        "eDP-1,1920x1080@60,0x0,1"
      ];
    };
    neovim.enable = true;
    zsh.enable = true;
    cursor.enable = true;
    git.enable = true;
    gnupg.enable = true;
    ssh.enable = true;
    vscodium.enable = true;
    discord.enable = true;
  };
}
