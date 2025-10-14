{ ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./coding
      ./colorscheme
      ./utils
      ./editor

      ./options.nix
    ];
  };

}
