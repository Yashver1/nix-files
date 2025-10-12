{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    enable = true;
    options.termguicolors = true;
    colorschemes.gruvbox.enable = true;
    };
}

