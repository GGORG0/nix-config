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
        diagnostics = {
          enable = true;
          styleLints.enable = true;
        };

        checkOnSave = true;

        check.command = "clippy";

        files.excludeDirs = [
          ".cargo"
          ".direnv"
          ".git"
          "node_modules"
          "target"
        ];

        procMacro.enable = true;

        rustc.source = "discover";
      };
    };
  };

}
