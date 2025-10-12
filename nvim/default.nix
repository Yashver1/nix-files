{ pkgs, ... }:
{
  programs.nixvim.enable = {
    imports = [
      # ./autocmd.nix
      ./keymaps.nix
      ./settings.nix
      ./plugins
    ];
  };
}
