{inputs, ...}:
{
  imports = [ 
    ./plugins
    ./keymaps.nix
    ./options.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
  };
}
