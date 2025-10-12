{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./keymaps.nix
      ./settings.nix
      ./plugins
    ];
  };

}
