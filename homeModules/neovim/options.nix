_: {
  programs.nixvim = {
    # use the system clipboard when copying/pasting
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      number = true; # enable line numbers
      relativenumber = true; # make line numbers relative
      signcolumn = "number"; # make signs (e.g. error indicators) replace the line number

      tabstop = 2; # <TAB> character gets rendered as 2 spaces
      expandtab = true; # pressing [TAB] key inserts spaces instead of <TAB> character
      softtabstop = 2; # pressing [TAB] key inserts 2 spaces
      shiftwidth = 2; # indenting inserts 2 spaces
      breakindent = true; # wrapped lines will preserve indentation

      mouse = "a"; # enables mouse everywhere

      undofile = true; # save undo history

      ignorecase = true; # ignore case in searches unless contains "\C"
      smartcase = true; # if search contains capital letter, don't ignore case

      termguicolors = true; # enable true color
    };
  };
}
