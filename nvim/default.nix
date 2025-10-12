{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    options.termguicolors = true;

    plugins.gruvbox.enable = true;  # load the plugin
    colorscheme = "gruvbox";        # set it as the active scheme
  };
}

