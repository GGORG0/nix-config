_: {
  # Language server - completion, error checking, etc.
  programs.nixvim.plugins.lsp = {
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
}
