_: {
  programs.nixvim = {
    plugins.which-key.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # -- GENERAL --
      {
        key = "<leader>fs";
        action = "<CMD>write<CR>";
        options.desc = "Save file";
      }

      {
        key = "<leader>q";
        action = "<CMD>quit<CR>";
        options.desc = "Quit";
      }

      {
        key = "<C-l>";
        action = "<CMD>noh<CR>";
        options.desc = "Clear search highlight";
      }

      # -- BUFFERS --
      {
        key = "<leader><TAB>";
        action = "<CMD>b#<CR>";
        options.desc = "Last used buffer";
      }

      {
        key = "<leader>bn";
        action = "<CMD>bnext<CR>";
        options.desc = "Next buffer";
      }

      {
        key = "<leader>bp";
        action = "<CMD>bprevious<CR>";
        options.desc = "Previous buffer";
      }

      {
        key = "<leader>bd";
        action = "<CMD>bd<CR>";
        options.desc = "Delete buffer";
      }
    ];
  };
}
