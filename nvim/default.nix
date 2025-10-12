{ pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./keymaps.nix
      ./treesitter.nix
      ./toggleterm.nix
      ./themes.nix
      ./lazygit.nix
      ./lualine.nix
      ./dashboard.nix
      ./bufferline.nix
      ./snacks.nix
      ./gitsigns.nix
      ./whichkey.nix
      ./hlchunk.nix
      ./yanky.nix
      ./autopairs.nix
      ./blink-cmp.nix
      ./kulala.nix
      ./tmux-navigator.nix
      ./smear-cursor.nix
      ./lsp/conform.nix
      ./lsp/fidget.nix
      ./lsp/lsp.nix
      ./nix-develop.nix
      ./aerial.nix
      ./autosave.nix
      ./notify.nix
      ./barbecue.nix
      ./noice.nix
      ./neoscroll.nix
      ./markview.nix
      ./zen-mode.nix
      ./yazi.nix
      ./wtf.nix
      ./ts-comments.nix
      ./timerly.nix
      ./treesj.nix
      ./web-devicons.nix
    ];
  };

}
