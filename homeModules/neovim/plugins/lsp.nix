_: {
  programs.nixvim = {
    # For lsp-lines
    diagnostics.virtual_text = false;
    plugins = {
      # Language server - completion, error checking, etc.
      lsp = {
        enable = true;

        inlayHints = true;

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

      # Show all LSP diagnostics using virtual lines
      lsp-lines.enable = true;

      # Custom LSP backend
      none-ls.enable = true;

      # Auto format on save
      lsp-format.enable = true;

      # Completion
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
            "<CR>" = "cmp.mapping.confirm({ select = false })";
          };

          experimental.ghost_text = true;

          cmdline = {
            "/" = {
              mapping = {
                __raw = "cmp.mapping.preset.cmdline()";
              };
              sources = [
                {
                  name = "buffer";
                }
              ];
            };
            ":" = {
              mapping = {
                __raw = "cmp.mapping.preset.cmdline()";
              };
              sources = [
                {
                  name = "path";
                }
                {
                  name = "cmdline";
                  option = {
                    ignore_cmds = [
                      "Man"
                      "!"
                    ];
                  };
                }
              ];
            };
          };
        };
      };

      # Completion in cmdline (: and /); see above for config
      cmp-cmdline.enable = true;

      # Snippets
      luasnip.enable = true;

      # Good snippet set
      friendly-snippets.enable = true;

      # Show a light bulb sign whenever code actions are available
      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd.enabled = true;
          float.enabled = false;
          line.enabled = false;
          number.enabled = false;
          sign.enabled = true;
          status_text.enabled = false;
          virtual_text.enabled = false;
        };
      };

      # Highlight other uses of the word/symbol under cursor
      illuminate.enable = true;

      # LSP renaming with previews
      inc-rename.enable = true;
      # TODO: make a keybind

      # Crates.io management + LSP server for completion
      crates-nvim = {
        enable = true;
        extraOptions = {
          lsp = {
            enabled = true;
            actions = true;
            completion = true;
            hover = true;
          };
          completion.crates = {
            enabled = true;
            max_results = 8;
            min_chars = 3;
          };
        };
      };
    };
  };
}
