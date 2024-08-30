_: {
  # Completion
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        enabled = {
          _raw = ''
            function()
              -- disable completion in comments
              local context = require 'cmp.config.context'

              -- keep command mode completion enabled when cursor is in a comment
              if vim.api.nvim_get_mode().mode == 'c' then
                return true
              else
                return not context.in_treesitter_capture("comment")
                  and not context.in_syntax_group("Comment")
              end
            end
          '';
        };

        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "luasnip";}
        ];

        snippet.expand = "luasnip";

        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })"; # TODO: make this a bit less annoying
        };

        experimental.ghost_text = true;
      };
    };

    # Snippet engine, required for some cmp plugins
    luasnip.enable = true;
  };
}
