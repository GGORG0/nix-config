_: {
  # Show all LSP diagnostics using virtual lines
  programs.nixvim = {
    diagnostics.virtual_text = false;
    plugins.lsp-lines.enable = true;
  };
}
