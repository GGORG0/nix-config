_: {
  programs.nixvim.plugins = {
    # Syntax highlighting and more
    treesitter = {
      enable = true;

      settings = {
        # how much grammar do you want installed? yes.
        ensure_installed = "all";

        highlight.enable = true;
        indent.enable = true;
      };
    };

    # Show code context on the top of the screen
    treesitter-context.enable = true;

    # Trim trailing whitespace and last & first newlines
    trim.enable = true;

    # Automatic pairing of (), {}, [], etc.
    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
      };
    };

    # Very powerful commenting plugin
    comment.enable = true;
  };
}
