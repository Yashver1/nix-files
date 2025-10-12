{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
  };
};

