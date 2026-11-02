{
  description = "My Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-nvim.url = "github:nixos/nixpkgs/0182a361324364ae3f436a63005877674cf45efb";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.brew-src.url = "github:Homebrew/brew/main";
    };

  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      ...
    }:
    {
      darwinConfigurations."Yashvers-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./giratina/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "yashver";
              autoMigrate = true;

              trust = {
                taps = [
                  "teamookla/speedtest"
                  "asmvik/formulae"
                  "felixkratz/formulae"
                ];
              };
            };
          }
        ];
      };

    };
}
