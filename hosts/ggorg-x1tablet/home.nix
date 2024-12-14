{pkgs, ...}: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      equibop
      element-desktop

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
    cursor.enable = true;
    git.enable = true;
  };
}
