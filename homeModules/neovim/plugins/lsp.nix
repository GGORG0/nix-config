_: {
  # Language server - completion, error checking, etc.
  programs.nixvim.plugins.lsp = {
    enable = true;

    inlayHints = true;

    servers = {
      clangd.enable = true;

      # maybe upgrade to rustaceanvim
      rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
        settings = {
          checkOnSave = true;
          check.command = "clippy";
          inlayHints = {
            enable = true;
            showParameterNames = true;
          };
          procMacro.enable = true;
        };
      };

      nil-ls = {
        enable = true;
        settings.formatting.command = [ "nixpkgs-fmt" ];
      };

      ts-ls = {
        enable = false;
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];
        extraOptions = {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
          };
        };
      };

      ruff-lsp.enable = true;

      jsonls.enable = true;
      html.enable = true;
      cssls.enable = true;
      eslint.enable = true;

      dockerls.enable = true;
      docker-compose-language-service.enable = true;

      bashls.enable = true;
    };
  };
}
