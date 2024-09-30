{ pkgs, ... }:
{
  programs.nixvim.plugins.rustaceanvim = {
    enable = true;

    rustAnalyzerPackage = pkgs.rust-bin.selectLatestNightlyWith
      (toolchain: toolchain.default.override {
        extensions = [ "rust-src" "rust-analyzer" ];
      });

    settings = {
      # I don't use DAP (yet)
      dap.autoloadConfigurations = false;

      server.default_settings.rust-analyzer = {
        cargo.features = "all";

        diagnostics = {
          enable = true;
          styleLints.enable = true;
        };

        checkOnSave = true;

        check = {
          command = "clippy";
          features = "all";
        };

        files.excludeDirs = [
          ".cargo"
          ".direnv"
          ".git"
          "node_modules"
          "target"
        ];

        inlayHints = {
          bindingModeHints.enable = true;
          closureStyle = "rust_analyzer";
          closureReturnTypeHints.enable = "always";
          discriminantHints.enable = "always";
          expressionAdjustmentHints.enable = "always";
          implicitDrops.enable = true;
          lifetimeElisionHints.enable = "always";
          rangeExclusiveHints.enable = true;
        };

        procMacro.enable = true;

        rustc.source = "discover";
      };
    };
  };

}
