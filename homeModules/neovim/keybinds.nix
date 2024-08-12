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
        options.desc = "No search highlight";
      }

      # -- BUFFERS --
      {
        key = "<leader>bb";
        action = "<CMD>Telescope buffers theme=dropdown<CR>";
        options.desc = "Switch buffers";
      }

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

      # -- TELESCOPE --
      {
        key = "<leader>ff";
        action = "<CMD>Telescope find_files<CR>";
        options.desc = "Find File (fuzzy)";
      }

      {
        key = "<leader>fr";
        action = "<CMD>Telescope file_browser<CR>";
        options.desc = "File bRowser";
      }

      {
        key = "<leader>fc";
        action = "<CMD>Telescope file_browser path=%:p:h<CR>";
        options.desc = "File browser in Current dir";
      }

      {
        key = "<leader>fo";
        action = "<CMD>Telescope oldfiles<CR>";
        options.desc = "Old Files";
      }

      {
        key = "<leader>fg";
        action = "<CMD>Telescope live_grep<CR>";
        options.desc = "Find w/ Grep";
      }

      {
        key = "<leader>fh";
        action = "<CMD>Telescope help_tags<CR>";
        options.desc = "Find Help";
      }

      {
        key = "<C-u>";
        action = "<CMD>Telescope undo<CR>";
        options.desc = "Undo tree";
      }
    ];
  };
}
