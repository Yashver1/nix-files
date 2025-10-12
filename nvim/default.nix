{config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;

    config = {
	options.termguicolors = true;
    	colorschemes.gruvbox.enable = true;


    };
      };
}

