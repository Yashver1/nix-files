{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
  };

  colorschemes.gruvbox.enable = true;
}

