{pkgs, ...}: {
  home = {
    # TODO: move to module
    packages = with pkgs; [
      # Messengers
      element-desktop

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

      # Local file sharing
      localsend
    ];
  };

  # --------------------

  # TODO: move to module
  programs.librewolf.enable = true;

  # --------------------

  ggorg = {
    development = {
      arduino.enable = true;
      gcc.enable = true;
      python.enable = true;
      rust.enable = true;
    };
    neovim.enable = true;
    zsh.enable = true;
    cursor.enable = true;
    git.enable = true;
    vscodium.enable = true;
    discord.enable = true;
  };
}
