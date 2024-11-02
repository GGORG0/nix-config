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
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "luasnip"; }
        ];

        snippet.expand = "luasnip";

        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                if require("luasnip").expandable() then
                  require("luasnip").expand()
                else
                  cmp.confirm({
                    select = true,
                  })
                end
              else
                fallback()
              end
            end)
          '';
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require("luasnip").locally_jumpable(1) then
                require("luasnip").jump(1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require("luasnip").locally_jumpable(-1) then
                require("luasnip").jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };

        experimental.ghost_text = true;
      };
    };

    # Snippet engine, required for some cmp plugins
    luasnip.enable = true;
  };
}
