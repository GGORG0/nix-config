_: {
  # Language server - completion, error checking, etc.
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notifyOnError = true;
        formattersByFt = {
          html = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          css = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          javascript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          javascriptreact = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          typescript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          typescriptreact = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          python = {
            __raw = ''
              function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                  return { "ruff_format" }
                else
                  return { "isort", "black" }
                end
              end
            '';
          };
          nix = {
            __unkeyed-1 = "alejandra";
            __unkeyed-2 = "nixpkgs-fmt";
            stop_after_first = true;
          };
          markdown = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          rust = ["rustfmt"];
        };
        default_format_opts.lsp_format = "fallback";
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
      };
    };

    opts.formatexpr = "v:lua.require'conform'.formatexpr()";

    keymaps = [
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format buffer";
        };
      }

      {
        mode = "v";
        key = "<leader>cF";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format selection";
        };
      }
    ];
  };
}
