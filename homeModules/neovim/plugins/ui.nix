_: {
  programs.nixvim.plugins = {
    # Top bar
    bufferline = {
      enable = true;
      alwaysShowBufferline = false;
      diagnostics = true;
      hover = {
        enabled = true;
        reveal = ["close"];
      };
    };

    # Bottom bar
    lualine.enable = true;

    # THE best fuzzy search plugin
    telescope = {
      enable = true;

      extensions = {
        file-browser = {
          enable = true;
          settings = {
            theme = "ivy";
            hijack_netrw = true;
            hidden = true;
            select_buffer = true;
          };
        };

        ui-select.enable = true;

        undo = {
          enable = true;
          settings = {
            side_by_side = true;
            layout_strategy = "vertical";
            layout_config.preview_height = 0.6;
            vim_diff_opts.ctxlen = 8;
          };
        };
      };
    };

    # Better notifications (works with noice)
    notify = {
      enable = true;

      stages = "slide";
      timeout = 2500;
      topDown = true;
      #      render = {__raw = "\"wrapped-compact\"";};
    };

    # Overall better UI popups
    noice = {
      enable = true;

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

    # Automatic session saving & restoring
    auto-session.enable = true;
  };
}
