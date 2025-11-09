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

    "plugins-vague" = {
      url = "github:vague-theme/vague.nvim";
      flake = false;
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixvim,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      nix-vscode-extensions,
      nixCats,
      niri,
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
