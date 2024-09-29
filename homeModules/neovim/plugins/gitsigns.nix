_: {
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings = {
        trouble = true;
        current_line_blame = false;
      };
    };
    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>gh";
        action = "gitsigns";
        options.desc = "+hunks";
      }
      {
        mode = "n";
        key = "<leader>ghb";
        action = ":Gitsigns blame_line<CR>";
        options.desc = "Blame line";
      }
      {
        mode = "n";
        key = "<leader>ghd";
        action = ":Gitsigns diffthis<CR>";
        options.desc = "Diff this";
      }
      {
        mode = "n";
        key = "<leader>ghp";
        action = ":Gitsigns preview_hunk<CR>";
        options.desc = "Preview hunk";
      }
      {
        mode = "n";
        key = "<leader>ghR";
        action = ":Gitsigns reset_buffer<CR>";
        options.desc = "Reset buffer";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>ghr";
        action = ":Gitsigns reset_hunk<CR>";
        options.desc = "Reset hunk";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>ghs";
        action = ":Gitsigns stage_hunk<CR>";
        options.desc = "Stage hunk";
      }
      {
        mode = "n";
        key = "<leader>ghS";
        action = ":Gitsigns stage_buffer<CR>";
        options.desc = "Stage buffer";
      }
      {
        mode = "n";
        key = "<leader>ghu";
        action = ":Gitsigns undo_stage_hunk<CR>";
        options.desc = "Undo stage hunk";
      }
    ];
  };
}
