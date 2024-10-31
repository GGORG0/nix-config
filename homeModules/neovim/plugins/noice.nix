_: {
  # Better UI popups
  programs.nixvim.plugins.noice = {
    enable = true;

    settings = {
      # override markdown rendering so that cmp and other plugins use Treesitter
      lsp.override = {
        "cmp.entry.get_documentation" = true;
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
      };

      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = true;
      };
    };
  };
}
