_: {
  # Top bar
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings.options = {
      alwaysShowBufferline = false;
      diagnostics = "nvim_lsp";
      hover = {
        enabled = true;
        reveal = [ "close" ];
      };
    };
  };
}
