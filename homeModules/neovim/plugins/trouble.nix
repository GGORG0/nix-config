_: {
  programs.nixvim = {
    plugins.trouble = {
      enable = true;
      settings = {
        auto_close = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>cx";
        action = "<cmd>TroubleToggle<cr>";
        options.desc = "Buffer diagnostics";
      }
      {
        mode = "n";
        key = "<leader>cX";
        action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
        options.desc = "Workspace diagnostics";
      }
      {
        mode = "n";
        key = "<leader>ct";
        action = "<cmd>TroubleToggle todo<cr>";
        options.desc = "Todo";
      }
      {
        mode = "n";
        key = "<leader>cq";
        action = "<cmd>TodoQuickFix<cr>";
        options.desc = "Quick fix list";
      }
    ];
  };
}
