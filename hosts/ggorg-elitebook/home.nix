{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/nix-conf.nix # Nix package manager configuration
    ../../modules/home-manager/common.nix # General shared configuration

    ../../modules/home-manager/rice/default.nix # My Hyprland rice
    ../../modules/home-manager/cursor.nix # Bibata cursor my beloved

    ../../modules/home-manager/doom-emacs/default.nix # Doom Emacs config
    ../../modules/home-manager/neovim/default.nix # Neovim config (w/Nixvim)

    ../../modules/home-manager/syncthing.nix # File sync
  ];

  # --------------------

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
}
