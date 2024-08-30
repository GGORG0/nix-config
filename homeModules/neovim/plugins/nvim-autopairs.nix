_: {
  # Automatic pairing of (), {}, [], etc.
  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    settings = {
      check_ts = true;
    };
  };
}
