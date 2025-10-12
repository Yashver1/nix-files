# MODULE SHAPE
{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;

    # everything else directly here (no extra `config = {}` needed)
    options.termguicolors = true;
    plugins.gruvbox.enable = true;  # your schema likely uses plugins + colorscheme
    colorscheme = "gruvbox";
  };
}

