{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.flutter-tools-nvim];
    extraConfigLua = ''
      require("flutter-tools").setup({})
    '';
  };
}
