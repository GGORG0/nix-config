_: {
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      show_end_of_buffer = true;
      transparent_background = true;
      integrations = {
        noice = true;
        notify = true;
        which_key = true;
      };
    };
  };
}
