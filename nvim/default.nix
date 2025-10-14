{ ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./coding
      ./colorscheme
      ./utils

      ./options.nix
    ];
  };

}
