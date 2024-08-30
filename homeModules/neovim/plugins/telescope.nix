_: {
  # THE best fuzzy search plugin
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        file-browser = {
          enable = true;
          settings = {
            theme = "ivy";
            hijack_netrw = true;
            hidden = true;
            select_buffer = true;
          };
        };

        ui-select.enable = true;

        undo = {
          enable = true;
          settings = {
            side_by_side = true;
            layout_strategy = "vertical";
            layout_config.preview_height = 0.6;
            vim_diff_opts.ctxlen = 8;
          };
        };
      };
    };
    keymaps = [
      {
        key = "<leader>bb";
        action = "<CMD>Telescope buffers theme=dropdown<CR>";
        options.desc = "Switch buffers";
      }

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
