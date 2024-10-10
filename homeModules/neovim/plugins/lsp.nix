_: {
  # Language server - completion, error checking, etc.
  programs.nixvim.plugins.lsp = {
    enable = true;

    inlayHints = true;

    servers = {
      clangd.enable = true;

      nil_ls = {
        enable = true;
        settings.formatting.command = [ "nixpkgs-fmt" ];
      };

      ts_ls = {
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

      ruff_lsp.enable = true;

      jsonls.enable = true;
      html.enable = true;
      cssls.enable = true;
      eslint.enable = true;

      dockerls.enable = true;
      docker_compose_language_service.enable = true;

      bashls.enable = true;
    };
  };
}
