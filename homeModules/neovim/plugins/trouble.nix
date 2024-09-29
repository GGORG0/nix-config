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
        action = "<cmd>Trouble diagnostics<cr>";
        options.desc = "Buffer diagnostics";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols<cr>";
        options.desc = "Buffer symbols";
      }
    ];
  };
}
