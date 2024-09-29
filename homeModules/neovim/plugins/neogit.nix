_: {
  # Awesome Git interface
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
      settings.disable_signs = true;
    };
    keymaps = [
      {
        key = "<leader>gg";
        action = "<CMD>:Neogit<CR>";
        options.desc = "Open Neogit";
      }
    ];
  };
}
