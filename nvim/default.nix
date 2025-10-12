{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    # using the wrapper => use the `.config = { ... }` style
    nixpkgs.useGlobalPackages = true;
    # (alternatively: nixpkgs.pkgs = pkgs;)

    config = {
      options.termguicolors = true;

      # your nixvim revision doesn't support `colorschemes.*` — use plugins + colorscheme
      plugins.gruvbox.enable = true;
      colorscheme = "gruvbox";
    };
  };
}

