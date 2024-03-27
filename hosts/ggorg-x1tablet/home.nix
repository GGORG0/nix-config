{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/nix-conf.nix # Nix package manager configuration
    ../../modules/home-manager/common.nix # General shared configuration

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

      # LibreOffice
      libreoffice-fresh
      hunspell
      hunspellDicts.pl-pl

      # Better calculator
      qalculate-gtk

      # YubiKey stuff
      yubioath-flutter
      yubikey-manager-qt

      # ProtonMail desktop client (official one requires paid account)
      electron-mail

      # Hand-written notes
      rnote
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;

  # --------------------

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
