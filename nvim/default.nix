{inputs, ...}:
{
  # Import all your configuration modules here
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim
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
