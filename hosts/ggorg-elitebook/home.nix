{
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ../../modules/home-manager/nix-conf.nix # Nix package manager configuration
    ../../modules/home-manager/common.nix # General shared configuration

    ../../modules/home-manager/rice/default.nix # My Hyprland rice
    ../../modules/home-manager/cursor.nix # Bibata cursor my beloved

    ../../modules/home-manager/doom-emacs/default.nix # Doom Emacs config

    ../../modules/home-manager/syncthing.nix # File sync
  ];

  # --------------------

  home = {
    # TODO: move to module
    packages =
      (with pkgs; [
        # Messengers
        # armcord
        telegram-desktop

        # Gaming
        prismlauncher
        mindustry

        # Programming
        android-studio

        # Misc
        libreoffice-fresh
        hunspell
        hunspellDicts.pl-pl

        qalculate-gtk

        rnote
      ])
      ++ (with pkgs-stable; [
        armcord # fix for installing ArmCord from stable repo to avoid https://snips.sh/f/bmCVQ3x63v caused by Electron 28
      ]);
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;
}
