{
  pkgs,
  inputs,
  nixpkgs,
  ...
}:
{
  imports = [
    ./homebrew.nix
    inputs.home-manager.darwinModules.home-manager
  ];
  nixpkgs.config.allowUnfree = true;
  nix.enable = false;
  environment.systemPackages = [
    pkgs.ttyper
    pkgs.fastfetch
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
  ];

  system.primaryUser = "yash-netvirta";
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  users.users.yash-netvirta = {
    name = "yash-netvirta";
    home = "/Users/yash-netvirta";
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "yash-netvirta" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
