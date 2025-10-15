{
  description = "My Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";

    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

  };

  outputs =
    inputs@{
      self,
      nixvim,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./arceus/configuration.nix
        ];
      };

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
            };
          }
        ];
      };

      darwinConfigurations."Yashs-MacBook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./mesprit/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "yash-netvirta";
              autoMigrate = true;
            };
          }
        ];
      };

    };
}
