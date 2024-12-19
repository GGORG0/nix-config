_: {
  # The mini.nvim suite
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      # Easy navigation with square brackets!
      bracketed = {};
    };
  };
}
