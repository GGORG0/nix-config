_: {
  # Syntax highlighting and more
  programs.nixvim.plugins.treesitter = {
    enable = true;

    settings = {
      # how much grammar do you want installed? yes.
      ensure_installed = "all";

      highlight.enable = true;
      indent.enable = true;
    };
  };
}
