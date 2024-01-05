{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/nix-conf.nix # Nix package manager configuration
    ../../modules/home-manager/common.nix # General shared configuration

    ../../modules/home-manager/rice/default.nix # My Hyprland rice

    ../../modules/home-manager/doom-emacs/default.nix # Doom Emacs config
  ];

  # --------------------

  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      armcord
      telegram-desktop

      # Gaming
      prismlauncher

      # Programming
      android-studio

      # Misc
      libreoffice-fresh
      hunspell
      hunspellDicts.pl-pl

      qalculate-gtk

      rnote
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;
}
