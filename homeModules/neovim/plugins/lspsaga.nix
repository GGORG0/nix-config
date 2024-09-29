_: {
  # More LSP features
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;
      beacon.enable = true;
      ui = {
        border = "rounded";
        codeAction = "💡";
      };
      diagnostic = {
        borderFollow = true;
        diagnosticOnlyCurrent = false;
        showCodeAction = true;
      };
      symbolInWinbar.enable = true;
      codeAction = {
        extendGitSigns = true;
        showServerName = true;
        onlyInCursor = true;
        numShortcut = true;
        keys = {
          exec = "<CR>";
          quit = [ "<Esc>" "q" ];
        };
      };
      lightbulb = {
        enable = true;
        sign = true;
        virtualText = false;
      };
      implement.enable = false;
      rename = {
        autoSave = false;
        keys = {
          exec = "<CR>";
          quit = [ "<C-k>" "<Esc>" ];
          select = "x";
        };
      };
      outline = {
        autoClose = true;
        autoPreview = true;
        closeAfterJump = true;
        layout = "normal"; # normal or float
        winPosition = "right"; # left or right
        keys = {
          jump = "e";
          quit = "q";
          toggleOrJump = "o";
        };
      };
      scrollPreview = {
        scrollDown = "<C-f>";
        scrollUp = "<C-b>";
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Lspsaga finder def<CR>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Lspsaga finder ref<CR>";
        options.desc = "Go to references";
      }

      {
        mode = "n";
        key = "gI";
        action = "<cmd>Lspsaga finder imp<CR>";
        options.desc = "Go to implementation";
      }

      {
        mode = "n";
        key = "gT";
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        options.desc = "Peek type definition";
      }

      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<CR>";
        options.desc = "Hover";
      }

      {
        mode = "n";
        key = "<leader>co";
        action = "<cmd>Lspsaga outline<CR>";
        options.desc = "Outline";
      }

      {
        mode = "n";
        key = "<leader>cr";
        action = "<cmd>Lspsaga rename<CR>";
        options.desc = "Rename";
      }

      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options.desc = "Code action";
      }

      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>Lspsaga show_line_diagnostics<CR>";
        options.desc = "Line diagnostics";
      }

      {
        mode = "n";
        key = "[d";
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        options.desc = "Next Diagnostic";
      }

      {
        mode = "n";
        key = "]d";
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        options.desc = "Previous Diagnostic";
      }
    ];
  };
}
