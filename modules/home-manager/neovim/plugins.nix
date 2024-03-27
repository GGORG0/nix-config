_: {
  programs.nixvim.plugins = {
    # Top bar
    bufferline.enable = true;

    # Bottom bar
    lualine.enable = true;

    # Command search
    telescope.enable = true;

    # Better file explorer than netrw
    oil.enable = true;

    # Better syntax highlighting
    treesitter.enable = true;

    # Discord RPC
    neocord.enable = true;

    # Overall better UI popups
    noice.enable = true;
  };
}
