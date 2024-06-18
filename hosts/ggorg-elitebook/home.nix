{pkgs, ...}: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      armcord
      telegram-desktop
      element-desktop

      # Gaming
      prismlauncher
      mindustry

      # LibreOffice
      libreoffice-fresh
      hunspell
      hunspellDicts.pl-pl
      kicad

      # Better calculator
      qalculate-gtk

      # YubiKey stuff
      yubioath-flutter
      yubikey-manager-qt

      # ProtonMail desktop client (official one requires paid account)
      electron-mail

      # Hand-written notes
      rnote

      # Screen recording
      obs-studio

      # Image editing
      gimp
      inkscape

      # Screen mirroring from Android
      scrcpy
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;

  # --------------------

  ggorg = {
    doomEmacs.enable = true;
    hyprland = {
      enable = true;
      monitors = [
        "eDP-1,1920x1080@60,0x0,1"
      ];
    };
    neovim.enable = true;
    zsh.enable = true;
    bibataCursor.enable = true;
    git.enable = true;
    syncthing.enable = true;
  };
}
