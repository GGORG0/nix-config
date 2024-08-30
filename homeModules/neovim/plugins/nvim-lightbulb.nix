_: {
  # Show a light bulb sign whenever code actions are available
  programs.nixvim.plugins.nvim-lightbulb = {
    enable = true;
    settings = {
      autocmd.enabled = true;
      float.enabled = false;
      line.enabled = false;
      number.enabled = false;
      sign.enabled = true;
      status_text.enabled = false;
      virtual_text.enabled = false;
    };
  };
}
