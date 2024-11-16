{ pkgs, ... }: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      legcord
      equibop
      element-desktop

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

      # Local file sharing
      localsend
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;

  # --------------------

  ggorg = {
    neovim.enable = true;
    zsh.enable = true;
    bibataCursor.enable = true;
    git.enable = true;
    syncthing.enable = true;
  };
}
