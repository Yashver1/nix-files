{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [
      # ./autocmd.nix
      ./keymaps.nix
      ./settings.nix
      ./plugins
    ];
  };
}
