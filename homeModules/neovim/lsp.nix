_: {
  programs.nixvim.plugins = {
    # Language server - completion, error checking, etc.
    lsp = {
      enable = true;

      servers = {
        # Rust
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };

        # Nix
        nil-ls.enable = true;
      };
    };

    # Completion
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];

        snippet.expand = "luasnip";

        mapping = {
          __raw = ''
            cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
          '';
        };
      };
    };

    # Snippets
    luasnip.enable = true;
  };
}
