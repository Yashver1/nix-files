{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    enable = true;
    options.termguicolors = true;
 };
}

