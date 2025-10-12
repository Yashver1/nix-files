{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    options.termguicolors = true;
    colorschemes.gruvbox.enable = true;
  };
}

